#!/usr/bin/python
#
__author__ = ('adaptee (Jekyll Wu), '
              'adaptee@google.com ')

import sys
import os.path
import getopt
import getpass
import re
import gdata.docs.service
import gdata.spreadsheet.service

def truncate(content, length=15, suffix='...'):
  if len(content) <= length:
    return content
  else:
    return content[:length] + suffix


class DocsSample(object):
  """A DocsSample object demonstrates the Document List feed."""

  def __init__(self, email, password):
    """Constructor for the DocsSample object.

    Takes an email and password corresponding to a gmail account to
    demonstrate the functionality of the Document List feed.

    Args:
      email: [string] The e-mail address of the account to use for the sample.
      password: [string] The password corresponding to the account specified by
          the email parameter.

    Returns:
      A DocsSample object used to run the sample demonstrating the
      functionality of the Document List feed.
    """
    source = 'Document List Python Sample'
    self.gd_client = gdata.docs.service.DocsService()
    self.gd_client.ClientLogin(email, password, source=source)


  def Run(self):

    rootfolder='gdocs'

    if not os.path.exists(rootfolder):
        os.mkdir(rootfolder)
    os.chdir(rootfolder)

    print "current folder :%s" %(os.getcwd(),)

    folderlist=self._GetFolderList()

    for folder in folderlist.entry:
        self._ExportFolder(folder)

  def _GetFolderList(self):
    """ Get folder list"""

    query = gdata.docs.service.DocumentQuery(categories=['folder'], params={'showfolders': 'true'})
    feed = self.gd_client.Query(query.ToUri())
    self._PrintFeed(feed)

    return feed


  def _PrintFeed(self, feed):
    """Prints out the contents of a feed to the console.
    Args:
      feed: A gdata.docs.DocumentListFeed instance.
    """
    print '\n'
    if not feed.entry:
      print 'No entries in feed.\n'
    print '%-18s %-12s %s' % ('TITLE', 'TYPE', 'RESOURCE ID')
    for entry in feed.entry:
      #print '%-18s %-12s %s' % (truncate(entry.title.text.encode('UTF-8')),
      print '%-18s %-12s %s' % (truncate(entry.title.text),
                                entry.GetDocumentType(),
                                entry.resourceId.text)


  def _ExportFolder(self,folder):

    foldername=folder.title.text

    print "\n"
    print 'I am processing folder %s' % (foldername,)

    if not os.path.exists(foldername):
      os.mkdir(foldername)

    oldfolder=os.getcwd()
    os.chdir(foldername)

    query = gdata.docs.service.DocumentQuery()
    query.AddNamedFolder("adaptee@gmail.com",foldername)

    feed = self.gd_client.Query(query.ToUri())

    for entry in feed.entry:

      resource_id=entry.resourceId.text
      filename=entry.title.text + '.zip'

      print 'Downloading document to %s...' % (filename,)
      self.gd_client.DownloadDocument(resource_id, filename)

    os.chdir(oldfolder)

def main():
  """Demonstrates use of the Docs extension using the DocsSample object."""
  # Parse command line options
  try:
    opts, args = getopt.getopt(sys.argv[1:], '', ['user=', 'pw='])
  except getopt.error, msg:
    print 'python docs_example.py --user [username] --pw [password] '
    sys.exit(2)

  user = 'adaptee'
  pw = '745688touchme'
  key = ''
  # Process options
  for option, arg in opts:
    if option == '--user':
      user = arg
    elif option == '--pw':
      pw = arg

  while not user:
    print 'NOTE: Please run these tests only with a test account.'
    user = raw_input('Please enter your username: ')
  while not pw:
    pw = getpass.getpass()
    if not pw:
      print 'Password cannot be blank.'

  try:
    sample = DocsSample(user, pw)
  except gdata.service.BadAuthentication:
    print 'Invalid user credentials given.'
    return

  sample.Run()

if __name__ == '__main__':
  main()
