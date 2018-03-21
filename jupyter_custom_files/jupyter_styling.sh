#!/bin/bash -e

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

JUPYTERSRC=${THISDIR}

# EVERYTHING BELOW HERE SHOULD JUST WORK....


#------- PROFILE: tm112MT -------
#------- Jupyter does not have a notion of profiles -------

###

IPYTHONDIR=$(ipython locate)

JUPYTERDATADIR=$(jupyter --data-dir)
JUPYTERCONFIGDIR=$(jupyter --config-dir)


echo "Ensuring default jupyter directories available"
#Ensure directories are available
mkdir -p $JUPYTERDATADIR
mkdir -p $JUPYTERCONFIGDIR


#These directories are where the original source files are located for the build
CUSTOMFILEPATH=$JUPYTERSRC/custom
NBCONFIGFILEPATH=$JUPYTERSRC/nbconfig
TPLTEMPLATESFILEPATH=$JUPYTERSRC/templates


#Directories on the VM that need to exist
TPLTEMPLATES=$JUPYTERDATADIR/templates #not sure about this
CUSTOMISATIONS=$JUPYTERCONFIGDIR/custom

echo "Ensuring required jupyter sub-directories available"
mkdir -p $TPLTEMPLATES
mkdir -p $CUSTOMISATIONS

#Startup files
echo "Ensuring jupyter startup files available"
STARTUP=$IPYTHONDIR/profile_default/startup
#mkdir -p $STARTUP
#cp $CUSTOMFILEPATH/tm351_start.ipy $STARTUP/tm351_start.ipy

#Styling and branding extensions
echo "Ensuring jupyter customisation files available"
cp $CUSTOMFILEPATH/* $JUPYTERCONFIGDIR/custom/


#nbconvert templating extensions
echo "Ensuring jupyter template extension files available"
cp -r $TPLTEMPLATESFILEPATH/* $TPLTEMPLATES/


#If not the Docker build, set up the services
if [[ -z "${DOCKERBUILD}" ]]; then
	systemctl restart jupyter.service
fi