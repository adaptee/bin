#!/usr/bin/python -u
#-*- coding: utf-8 -*-
#
# After connecting to a jabber server it will echo messages, and accept any
# presence subscriptions. This bot has basic Disco support (implemented in
# pyxmpp.jabber.client.Client class) and jabber:iq:vesion.

import sys
import logging
import locale
import codecs

from pyxmpp import streamtls
from pyxmpp.all import JID, Iq, Presence, Message, StreamError
from pyxmpp.jabber.client import JabberClient
from pyxmpp.interface import implements
from pyxmpp.interfaces import *

class EchoHandler(object):
    """提供一个机器人的回答功能
    对于presence和message XML节的处理器的实现
    """

    implements(IMessageHandlersProvider, IPresenceHandlersProvider)

    def __init__(self, client):
        """Just remember who created this."""
        self.client = client

    def get_message_handlers(self):
        """Return list of (message_type, message_handler) tuples.

        The handlers returned will be called when matching message is received
        in a client session."""
        return [("normal", self.message)]

    def get_presence_handlers(self):
        """Return list of (presence_type, presence_handler) tuples.

        The handlers returned will be called when matching presence stanza is
        received in a client session."""
        return [
            (None, self.presence),
            ('unavailable', self.presence),
            ('subscribe', self.presence_control),
            ('subscribed', self.presence_control),
            ('unsubscribe', self.presence_control),
            ('unsubscribed', self.presence_control)]

    def message(self, stanza):
        """Message handler for the component.

        Echoes the message back if its type is not 'error' or
        'headline', also sets own presence status to the message body. Please
        note that all message types but 'error' will be passed to the handler
        for 'normal' message unless some dedicated handler process them.

        :returns: `True` to indicate, that the stanza should not be processed
        any further."""
        subject = stanza.get_subject()
        body = stanza.get_body()
        t = stanza.get_type()
        print u'收到[%s]的信息。' % (unicode(stanza.get_from(),)),
        if subject:
            print u'主题是: "%s"。' % (subject,),
        if body:
            print u'正文是: "%s"。' % (body,),
        if t:
            print u'类型是: "%s"。' % (t,)
        else:
            print u'类型: "正常"。'

        if stanza.get_type() == 'headline':
            # 'headline' messages should never be replied to
            return True

        if subject:
            subject = u'Re: ' + subject
        m = Message(
                to_jid=stanza.get_from(),
                from_jid=stanza.get_to(),
                stanza_type=stanza.get_type(),
                subject=subject,
                body=body)
        if body:
            p = Presence(status=u'新签名：' + body)
            return [m, p]
        return m

    def presence(self, stanza):
        """Handle 'available' (without 'type') and 'unavailable' <presence/ >."""
        msg = u'%s has become ' % (stanza.get_from())
        t = stanza.get_type()
        if t == 'unavailable':
            msg += u'离线'
        else:
            msg += u'上线'

        show = stanza.get_show()

        if show:
            msg += u'(%s)' % (show,)

        status = stanza.get_status()
        if status:
            msg += u': '+status
        print msg

    def presence_control(self, stanza):
        """Handle subscription control <presence /> stanzas -- acknowledge
        them."""
        msg = unicode(stanza.get_from())
        t = stanza.get_type()
        if t == 'subscribe':
            msg += u' has requested presence subscription.'
        elif t == 'subscribed':
            msg += u' has accepted our presence subscription request.'
        elif t =='unsubscribe':
            msg += u' has canceled his subscription of our.'
        elif t == 'unsubscribed':
            msg += u' has canceled our subscription of his presence.'

        print msg

        #Create "accept" response for the "subscribe"/"subscribed"/"unsubscribe"/"unsubscribed" presence stanza.
        return stanza.make_accept_response()

class VersionHandler(object):
    """Provides handler for a version query.

    This class will answer version query and announce 'jabber:iq:version' namespace
    in the client's disco#info results."""

    implements(IIqHandlersProvider, IFeaturesProvider)

    def __init__(self, client):
        """Just remember who created this."""
        self.client = client

    def get_features(self):
        """Return namespace which should the client include in its reply to a
        disco#info query."""
        return ["jabber:iq:version"]

    def get_iq_get_handlers(self):
        """Return list of tuples (element_name, namespace, handler) describing
        handlers of <iq type='get' /> stanzas"""
        return [
            ("query", "jabber:iq:version", self.get_version),]

    def get_iq_set_handlers(self):
        """Return empty list, as this class provides no <iq type='set'/ > stanza handler."""
        return []

    def get_version(self,iq):
        """Handler for jabber:iq:version queries.

        jabber:iq:version queries are not supported directly by PyXMPP, so the
        XML node is accessed directly through the libxml2 API.  This should be
        used very carefully!"""
        iq = iq.make_result_response()
        q = iq.new_query("jabber:iq:version")
        q.newTextChild(q.ns(),"name","Echo component")
        q.newTextChild(q.ns(),"version","1.0")
        return iq

class Client(JabberClient):
    """Simple bot (client) example. Uses `pyxmpp.jabber.client.JabberClient`
    class as base. That class provides basic stream setup (including
    authentication) and Service Discovery server. It also does server address
    and port discovery based on the JID provided."""

    def __init__(self, jid, password):
        # if bare JID is provided add a resource -- it is required
        if not jid.resource:
            jid=JID(jid.node, jid.domain, 'w3erbot')

        #tls验证设置
        tls = streamtls.TLSSettings(require=True, verify_peer=False)
        auth = ['sasl:PLAIN']

        # setup client with provided connection information
        # and identity data
        JabberClient.__init__(self, jid, password,
                disco_name='W3er Bot', disco_type='bot',
                tls_settings=tls, auth_methods=auth)

        # 添加自己实现的组件
        self.interface_providers = [
            VersionHandler(self),
            EchoHandler(self),
        ]

    def stream_state_changed(self,state,arg):
        """This one is called when the state of stream connecting the component
        to a server changes. This will usually be used to let the user
        know what is going on."""
        print "*** State changed: %s %r ***" % (state,arg)

    def print_roster_item(self,item):
        if item.name:
            name = item.name
        else:
            name = u''
        print (u'%s "%s" 订阅=%s 群组=%s'
                % (unicode(item.jid), name, item.subscription,
                    u','.join(item.groups)) )

    def roster_updated(self,item=None):
        if not item:
            print u'花名册'
            for item in self.roster.get_items():
                self.print_roster_item(item)
            return
        print u'花名册更新完毕'
        self.print_roster_item(item)

# XMPP protocol is Unicode-based to properly display data received
# _must_ convert it to local encoding or UnicodeException may be raised
locale.setlocale(locale.LC_CTYPE, "")
encoding = locale.getlocale()[1]
if not encoding:
    encoding = "us-ascii"
sys.stdout = codecs.getwriter(encoding)(sys.stdout, errors = "replace")
sys.stderr = codecs.getwriter(encoding)(sys.stderr, errors = "replace")

if len(sys.argv) < 3:
    print u"Usage:"
    print "\t%s JID password" % (sys.argv[0],)
    print "example:"
    print "\t%s test@localhost verysecret" % (sys.argv[0],)
    sys.exit(1)

print u'创建客户端实例'
c = Client(JID(sys.argv[1]), sys.argv[2])

print u'开始连接服务器'
c.connect()

print u'开始监控'
try:
    c.loop(1)
except KeyboardInterrupt:
    print u'与服务器断开连接'
    c.disconnect()

print u'退出程序'

