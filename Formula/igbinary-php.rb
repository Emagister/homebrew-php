require 'formula'

class IgbinaryPhp < Formula
  homepage 'http://pecl.php.net/package/igbinary'
  url 'http://pecl.php.net/get/igbinary-1.1.1.tgz'
  version '1.1.1'
  
  head 'https://github.com/phadej/igbinary.git'

  depends_on 'autoconf'

  def install
    Dir.chdir "igbinary-#{version}" do
      system "phpize"
      system "./configure", "--prefix=#{prefix}"
      system "make"

      prefix.install 'modules/igbinary.so'
    end
  end

  def caveats; <<-EOS.undent
    To finish installing igbinary-php:
      * Add the following lines to #{etc}/php.ini:
        [apc]
        extension="#{prefix}/igbinary.so"
        igbinary.compact_strings = Off

      * Restart your webserver.
      * Write a PHP page that calls "phpinfo();"
      * Load it in a browser and look for the info on the igbinary module.
      * If you see it, you have been successful!
    EOS
  end
end