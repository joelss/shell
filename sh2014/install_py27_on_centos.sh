#!/bin/bash

# install some necessary toos & libs
yum groupinstall "Development tools"
yum install openssl-devel zlib-devel ncurses-devel bzip2-devel readline-devel
yum install libtool-ltdl-devel sqlite-devel tk-devel tcl-devel

# download and install python
version='2.7.8'
python_url="https://www.python.org/ftp/python/$version/Python-${version}.tgz"

cd /tmp
wget $python_url
tar -zxf Python-${version}.tgz
cd Python-${version}
./configure
make -j 4
make install

python -V | grep "$version"
if [ $? -ne 0 ]; then
  echo "python -V is not your installed version"
  /usr/local/bin/python -V | grep "$version"
  if [ $? -ne 0 ]; then
    echo "installation failed. use '/usr/local/bin/python -V' to have a check"
  fi
  exit 1
fi

# install setuptools
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
python ez_setup.py
# check easy_install version
easy_install --version

# install pip for the new python
easy_install pip
# check pip version
pip -V

echo "Finished. Well done!"
