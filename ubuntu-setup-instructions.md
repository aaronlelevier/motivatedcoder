# Ubuntu setup instructions

Notes on how to install and configure Erlang for Unbuntu

## Initial setup

**Env VARs**

```

export ERL_TOP=/home/ubuntu/otp_src_22.1

# fixes issues on some systems w/ Perl (not sure if I need this?)
export LANG=C
```

**Code:**

Ubuntu Dependencies

IMPORTANT - must be installed before Erlang, if `openssl` isn't present, Erlang won't install crypto.so, etc.. and will have issues

```
# gcc deps
sudo apt-get install build-essential

sudo apt-get update --fix-missing

# openssl
sudo apt-get install libssl-dev

# erl deps
sudo apt-get install libncurses5-dev libncursesw5-dev
```

Erlang Install

**Docs:**

[How to Build and Install Erlang/OTP](http://erlang.org/doc/installation_guide/INSTALL.html#how-to-build-and-install-erlang-otp)

```
# erl
wget http://www.erlang.org/download/otp_src_22.1.tar.gz
tar -zxf otp_src_22.1.tar.gz
cd otp_src_22.1
export ERL_TOP=`pwd`   
./configure
export LANG=C
# build
make

# make smoke tests and run them
make release_tests
cd release/tests/test_server
$ERL_TOP/bin/erl -s ts install -s ts smoke_test batch -s init stop

# final install
make install

# ling path
PATH="/home/ubuntu/otp_src_22.1/bin:${PATH}"
# or
sudo ln -s /home/ubuntu/otp_src_22.1/bin/ /usr/local/bin/
```

**Rebar3 install**

[rebar3 docs](https://github.com/erlang/rebar3#getting-started)

```
wget https://s3.amazonaws.com/rebar3/rebar3 && chmod +x rebar3
PATH="/home/ubuntu/rebar3:${PATH}"
```

# Install try 2 (working :)

Base [blog](https://tecadmin.net/install-erlang-on-ubuntu/) installation documenting process

Ubuntu Packages needed

```
# gcc deps
sudo apt-get install build-essential

# needed to locate openssl
sudo apt-get update --fix-missing

# openssl
sudo apt-get install libssl-dev

# erl deps
sudo apt-get install libncurses5-dev libncursesw5-dev
```

[Downloads from Erlang Solutions](https://www.erlang-solutions.com/resources/download.html)

```
# Needed before *.deb for Erlang install would work
sudo apt-get install libsctp1
sudo apt --fix-broken install

# Then install
wget https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_22.1.8-1~ubuntu~bionic_amd64.deb
sudo dpkg -i esl-erlang_22.1.8-1~ubuntu~bionic_amd64.deb
```
