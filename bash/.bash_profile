if [ -f ~/.bashrc ];
  then source ~/.bashrc
fi

PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:/usr/local/Cellar/imagemagick/6.8.0-10/lib/pkgconfig/:$PKG_CONFIG_PATH"
