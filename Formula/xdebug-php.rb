require 'formula'

class XdebugPhp < Formula
  homepage 'http://xdebug.org'
  url 'http://pecl.php.net/get/xdebug-2.2.0RC1.tgz'
  md5 '002b2b60fe7d044526fa5ca00caf5f7b'
  version '2.2.0RC1'

  depends_on 'autoconf'

  def install
    Dir.chdir "xdebug-#{version}" do
      # See https://github.com/mxcl/homebrew/issues/issue/69
      ENV.universal_binary

      system "phpize"
      system "./configure", "--disable-debug", "--disable-dependency-tracking",
                            "--prefix=#{prefix}",
                            "--enable-xdebug"
      system "make"
      prefix.install 'modules/xdebug.so'
    end
  end

  def caveats; <<-EOS.undent
    To finish installing xdebug-php:
      * Add the following line to #{etc}/php.ini:
        zend_extension="#{prefix}/xdebug.so"
      * Restart your webserver.
      * Write a PHP page that calls "phpinfo();"
      * Load it in a browser and look for the info on the xdebug module.
      * If you see it, you have been successful!
    EOS
  end
end
