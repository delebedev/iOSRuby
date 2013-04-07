#!/bin/sh
make clean

./configure --enable-wide-getaddrinfo --disable-dln --with-static-linked-ext --without-gcc --disable-install-rdoc --host=arm-apple-darwin10 --target=arm-apple-darwin10 \
 LD=clang AR=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/ar \
 ac_cv_func_getpgrp_void=yes ac_cv_func_setpgrp_void=yes \
 RANLIB=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/ranlib \
 CFLAGS="-arch armv7 -fmessage-length=0 -pipe -Wno-trigraphs -fpascal-strings -Os -Wreturn-type -Wunused-variable -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk" \
 LDFLAGS="-arch armv7 -L/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk/usr/lib/ -L/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk/usr/lib/system/ -fstack-protector -read_only_relocs suppress -arch armv7"

 make

ar r libruby-static.a ext/bigdecimal/bigdecimal.o
ar r libruby-static.a ext/coverage/coverage.o
ar r libruby-static.a ext/date/*.o
ar r libruby-static.a ext/dbm/*.o

ar r libruby-static.a ext/digest/digest.o
ar r libruby-static.a ext/digest/bubblebabble/bubblebabble.o
ar r libruby-static.a ext/digest/MD5/*.o
ar r libruby-static.a ext/digest/rmd160/*.o
ar r libruby-static.a ext/digest/sha1/*.o
ar r libruby-static.a ext/digest/sha2/*.o

ar r libruby-static.a ext/socket/*.o

ar r libruby-static.a ext/etc/etc.o
ar r libruby-static.a ext/fcntl/fcntl.o
ar r libruby-static.a ext/fiber/fiber.o
ar r libruby-static.a ext/io/console/console.o
ar r libruby-static.a ext/io/nonblock/nonblock.o
ar r libruby-static.a ext/io/wait/wait.o

ar r libruby-static.a ext/strscan/strscan.o
ar r libruby-static.a ext/objspace/objspace.o
ar r libruby-static.a ext/pathname/pathname.o
ar r libruby-static.a ext/pty/pty.o
ar r libruby-static.a ext/sdbm/*.o
ar r libruby-static.a ext/stringio/stringio.o

ar r libruby-static.a ext/json/parser/parser.o
ar r libruby-static.a ext/json/generator/generator.o



ar r libruby-static.a enc/*.o
