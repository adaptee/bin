#!/usr/bin/env python
# Usage: python purge_unused_adobe_plugins.py [r|p]

import os
import sys
import shutil

nouse_plugins_for_reader = [
                                'Accessibility.api',
                                'Accessibility.CHS',
                                'DigSig.api',
                                'DigSig.CHS',
                                'HLS.api',
                                'HLS.CHS',
                                'MakeAccessible.api',
                                'MakeAccessible.CHS',
                                'Multimedia.api',
                                'Multimedia.CHS',
                                'PDDom.api' ,
                                'PDDom.CHS' ,
                                'PPKLite.api',
                                'PPKLite.CHS',
                                'ReadOutLoud.api' ,
                                'ReadOutLoud.CHS' ,
                                'SaveAsRTF.api' ,
                                'SaveAsRTF.CHS' ,
                                'SendMail.api',
                                'SendMail.CHS',
                            ]

nouse_plugins_for_professional = [
                                    'Accessibility.api',
                                    'Accessibility.CHS',
                                    #'DigSig.api',
                                    #'DigSig.CHS',
                                    'HLS.api',
                                    'HLS.CHS',
                                    'MakeAccessible.api',
                                    'MakeAccessible.CHS',
                                    'Multimedia.api',
                                    'Multimedia.CHS',
                                    'PDDom.api' ,
                                    'PDDom.CHS' ,
                                    #'PPKLite.api',
                                    #'PPKLite.CHS',
                                    'ReadOutLoud.api' ,
                                    'ReadOutLoud.CHS' ,
                                    'SaveAsRTF.api' ,
                                    'SaveAsRTF.CHS' ,
                                    'SendMail.api',
                                    'SendMail.CHS',

                                    # specific for professional
                                    'ADBC.api',
                                    'ADBC.CHS',
                                    'Catalog.api',
                                    'DVA.api',
                                    'DVA.CHS',
                                    'DistillerPI.api',
                                    'ebook.api',
                                    'ebook.CHS',
                                    'EWH32.api',
                                    'EWH32.CHS',
                                    'FlattenerView.api',
                                    'FlattenerView.CHS',
                                    'HTML2PDF.api',
                                    'HTML2PDF.CHS',

                                    'ImageConversion.api',
                                    'ImageConversion.CHS',
                                    'ImageViewer.api',
                                    'ImageViewer.CHS',

                                    #'IA32.api',
                                    #'IA32.CHS',

                                    'JDFProdDef.api',
                                    'JDFProdDef.CHS',
                                    'LegalPDF.api'  ,
                                    'LegalPDF.CHS'  ,

                                    'PaperCapture.api',
                                    'PaperCapture.CHS',
                                    'PictureTasks.api',
                                    'PictureTasks.CHS',

                                    'Preflight.api',
                                    'Preflight.CHS',

                                    'SaveAsXML.api',
                                    'SaveAsXML.CHS',

                                    #'Soap.api',
                                    #'Soap.CHS',

                                    'TablePicker.api',
                                    'TablePicker.CHS',
                                    'TouchUp.api',
                                    'TouchUp.CHS',
                                    'Updater.api',
                                    'Updater.CHS',
                                    'WebPDF.api',
                                    'WebPDF.CHS',
                                ]

if (len(sys.argv) >1 and sys.argv[1] == 'p'):
    version = 'professional'
    nouse_plugins = nouse_plugins_for_professional
else:
    version = 'reader'
    nouse_plugins = nouse_plugins_for_reader

if "win32" in sys.platform:
    if ( version == 'reader' ):
        plugins_folder = r"C:\Program Files\Adobe\Reader 9.0\Reader\plug_ins"
    else:
        plugins_folder = r"C:\Program Files\Adobe\Acrobat 7.0\Acrobat\plug_ins"

elif "linux" in sys.platform:
    #plugins_folder = "/opt/Adobe/Reader9/Reader/intellinux/plug_ins"
    plugins_folder = "/usr/lib/acroread/Reader/intellinux/plug_ins"


parent_folder = os.path.dirname(plugins_folder)
nouse_plugins_folder = os.path.join( parent_folder,"nouse_plugins")

shutil.rmtree( nouse_plugins_folder)
os.mkdir( nouse_plugins_folder)

for item in os.listdir(plugins_folder):
    print "\nitem:\t" + item
    if item in nouse_plugins:
        shutil.move( os.path.join( plugins_folder, item), nouse_plugins_folder )
        print item + " is not useful.\n"
    else:
        print item + " is useful\n"

