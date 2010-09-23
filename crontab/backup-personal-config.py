#!/usr/bin/env python
import os
import sys
import shutil
import time
import zipfile
import zlib

home_dir = os.getenv("HOME")

if "win32" in sys.platform:
    dropbox_dir = r"C:\Documents and Settings\jekyll.wu\Desktop\My Dropbox\Config"
else:
    dropbox_dir = os.path.join( home_dir, "Desktop/Dropbox/Config")

name_mapping = {}

name_mapping[ os.path.join ( home_dir ,".profile"      ) ] = os.path.join ( dropbox_dir, "_profile"       )
name_mapping[ os.path.join ( home_dir ,".bashrc"       ) ] = os.path.join ( dropbox_dir, "_bashrc"        )
name_mapping[ os.path.join ( home_dir ,".inputrc"      ) ] = os.path.join ( dropbox_dir, "_inputrc"       )
name_mapping[ os.path.join ( home_dir ,".screenrc"     ) ] = os.path.join ( dropbox_dir, "_screenrc"      )
name_mapping[ os.path.join ( home_dir ,".vimperatorrc" ) ] = os.path.join ( dropbox_dir, "_vimperatorrc"  )
name_mapping[ os.path.join ( home_dir ,".vimperator"   ) ] = os.path.join ( dropbox_dir, "vimperator.zip" )
name_mapping[ os.path.join ( home_dir ,".vimrc"        ) ] = os.path.join ( dropbox_dir, "_vimrc"         )
name_mapping[ os.path.join ( home_dir ,".vim"          ) ] = os.path.join ( dropbox_dir, "vimfiles.zip"   )
name_mapping[ os.path.join ( home_dir ,".bash.d"       ) ] = os.path.join ( dropbox_dir, "bash-d.zip"     )
name_mapping[ os.path.join ( home_dir ,".mozilla/firefox/prefs.js"       ) ] = os.path.join ( dropbox_dir, "prefs.js")

def dateOfToday():
    (year,month,day) = time.localtime()[:3]
    date = "%4d-%02d-%02d" % (year,month,day)
    return date

def addToArchive( archive,dirname,filelist):
    for item in filelist:
        fullpath = os.path.join(dirname,item)
	# only need to explicitly add files; the files' path will be used to record hierarchy implicitly
        if os.path.isfile(fullpath):
            archive.write(fullpath)

def createZipArchive(top_folder,archive_name):
    # ZIP_DEFLATED means "do compression,really"
    archive = zipfile.ZipFile(file=archive_name, mode='w', compression=zipfile.ZIP_DEFLATED)
    os.path.walk( top_folder, addToArchive, archive)
    archive.close()

def backupconfig():

    date = dateOfToday()
    older_backup = os.path.join(dropbox_dir,date)

    if not os.path.exists(older_backup):
        os.mkdir(older_backup)

    for item in name_mapping.keys():
        print "processing %s" % (item)
        filename = os.path.basename(name_mapping[item])

        # move existing backup to an separate folder named by the date
        if os.path.exists( name_mapping[item]):
           shutil.move(name_mapping[item],os.path.join(older_backup,filename) )

        if os.path.isfile(item):
            shutil.copyfile( item , name_mapping[item] )
        elif os.path.isdir(item):
            os.chdir( item )
            createZipArchive('.',name_mapping[item])

        print "%s ==> %s" % (item,name_mapping[item])
        print

    print "All is done."

if __name__ == "__main__": backupconfig()
