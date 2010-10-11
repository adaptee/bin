#!/usr/bin/env python
import os
import sys
import glob
import shutil
import zipfile

homedir      = os.getenv("HOME")
vimdir       = os.getenv("VIM")
name_mapping = {}

name_mapping["_profile"]       = os.path.join(homedir,".profile")
name_mapping["_bashrc"]        = os.path.join(homedir,".bashrc")
name_mapping["_inputrc"]       = os.path.join(homedir,".inputrc")
name_mapping["_screenrc"]      = os.path.join(homedir,".screenrc")

if "win32" in sys.platform:
    dropbox_dir                    = r"C:\Documents and Settings\jekyll.wu\Desktop\My Dropbox\Config"
    name_mapping["_vimrc"]         = os.path.join(vimdir,"_vimrc")
    name_mapping["vimfiles.zip"]   = os.path.join(vimdir,"vimfiles")
    name_mapping["_vimperatorrc"]  = os.path.join(homedir,"_vimperatorrc")
    name_mapping["vimperator.zip"] = os.path.join(homedir,"vimperator")
    name_mapping["_profile"]       = os.path.join(homedir,".profile")
    name_mapping["_bashrc"]        = os.path.join(homedir,".bashrc")
    name_mapping["_inputrc"]       = os.path.join(homedir,".inputrc")
    name_mapping["_screenrc"]      = os.path.join(homedir,".screenrc")
    name_mapping["bash-d.zip"]     = os.path.join(homedir,".bash.d")

else:
    dropbox_dir                    = os.path.join ( os.getenv( "HOME"),"Desktop/Dropbox/Config")
    name_mapping["_vimrc"]         = os.path.join ( homedir,".vimrc")
    name_mapping["vimfiles.zip"]   = os.path.join ( homedir,".vim")
    name_mapping["_vimperatorrc"]  = os.path.join(homedir,".vimperatorrc")
    name_mapping["vimperator.zip"] = os.path.join(homedir,".vimperator")

# delete all items under specified folder
def clearfolder(folder):
    for item in glob.glob(folder + '/*'):
        if os.path.isfile(item):
            os.remove(item)
        else:
            shutil.rmtree(item)

# remove the trailing path separator in a folder path
def trim_trailing_sep(path):
    if path[-1] == os.path.sep:
        return path[:-1]
    else:
        return path

def prepare_hierarchy(folder):

    if folder :
        target_folder = trim_trailing_sep(folder)
        print "target_folder:%s" % target_folder

        if  target_folder and not os.path.exists(target_folder) :
            prepare_hierarchy( os.path.dirname(target_folder) )
            os.mkdir(target_folder)
        else:
            pass

# unzip archive under specified parent folder
def do_unzip(zip_file, root_folder):

    prepare_hierarchy(root_folder)

    old_path = os.getcwd()
    os.chdir( root_folder )

    try:
        for item in zip_file.namelist():
            #print "item:%s" % (item)

            if not os.path.basename(item):      #proecess folder
                print item + " is a folder"
                prepare_hierarchy(item)
            else:                               #process file
                upper_level = os.path.dirname(item)
                prepare_hierarchy(upper_level)
                open(item,'w').write( zip_file.read(item) )
    finally:
        os.chdir(old_path)

# clear target folder and call do_unzip()
def unzip(zip_archive, root_folder):

    clearfolder(root_folder)
    zip_file = zipfile.ZipFile(zip_archive,'r')
    do_unzip(zip_file, root_folder)

# restore config from Dropbox or current folder
def restoreconfig(source_dir=None):

    # fall-back scheme: using current folder as source
    if not source_dir or not os.path.exists(source_dir):
        source_dir = os.getcwd()

    print "source_dir:%s" % (source_dir)

    for filename in name_mapping.keys():

        fullpath = os.path.join(source_dir, filename)

        if ".zip" in fullpath:
            unzip(fullpath, name_mapping[filename])
        else:
            shutil.copyfile( fullpath, name_mapping[filename] )

        print "%s\t\t ==> %s done" % (filename, name_mapping[filename])

    print "All is done."

if __name__ == '__main__':
    restoreconfig(dropbox_dir)
