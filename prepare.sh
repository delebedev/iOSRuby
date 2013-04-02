curl -O http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p0.tar.gz
tar -xzf ruby-2.0.0-p0.tar.gz
cd ruby-2.0.0-p0
patch -p1 -d . < ../iOS-changes.patch
sh ../build.sh
