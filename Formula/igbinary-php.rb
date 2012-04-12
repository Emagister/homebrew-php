require 'formula'

class IgbinaryPhp < Formula
  homepage 'http://pecl.php.net/package/igbinary'
  url 'http://pecl.php.net/get/igbinary-1.1.1.tgz'
  version '1.1.1'
  md5 '4ad53115ed7d1d452cbe50b45dcecdf2'
  
  head 'https://github.com/phadej/igbinary.git'

  depends_on 'autoconf'

  def install
    Dir.chdir "igbinary-#{version}" do
      system "phpize"
      system "./configure", "--prefix=#{prefix}"
      system "make"
      
      # Copy the header file need by memcached-php
      Dir.mkdir "#{Formula.factory('php').include}/php/ext/igbinary" unless File.exists? "#{Formula.factory('php').include}/php/ext/igbinary"
      system "cp igbinary.h #{Formula.factory('php').include}/php/ext/igbinary/igbinary.h"

      prefix.install 'modules/igbinary.so'
    end
  end

  def caveats; <<-EOS.undent
    To finish installing igbinary-php:
      * Add the following lines to #{etc}/php.ini:
        [igbinary]
        extension="#{prefix}/igbinary.so"
        igbinary.compact_strings = Off

      * Restart your webserver.
      * Write a PHP page that calls "phpinfo();"
      * Load it in a browser and look for the info on the igbinary module.
      * If you see it, you have been successful!
    EOS
  end
end