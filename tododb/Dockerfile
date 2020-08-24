FROM mysql:5.7

# Set debian default locale to ja_JP.UTF-8
RUN apt-get update && \
    apt-get install -y locales && \
    rm -rf /var/lib/apt/lists/* && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8

# Set MySQL character
RUN { \
    echo '[mysqld]'; \
    echo 'character-set-server=utf8mb4'; \
    echo 'collation-server=utf8mb4_general_ci'; \
    echo '[client]'; \
    echo 'default-character-set=utf8mb4'; \
} > /etc/mysql/conf.d/charset.cnf

# (1) パッケージアップデートとwgetインストール
# RUN apt-get update
# RUN apt-get install -y wget

# Set debian default locale to ja_JP.UTF-8
# RUN apt-get update && \
#     apt-get install -y locales && \
#     rm -rf /var/lib/apt/lists/* && \
#     echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
#     locale-gen ja_JP.UTF-8
# ENV LC_ALL ja_JP.UTF-8

# RUN apt-get update && apt-get install -y locales \
#   --no-install-recommends && rm -rf /var/lib/apt/lists/*

# RUN dpkg-reconfigure locales && \
#     locale-gen C.UTF-8 && \
#     /usr/sbin/update-locale LANG=C.UTF-8

# ENV LC_ALL C.UTF-8
# ENV TERM xterm

# # (3) スクリプトと各種設定ファイルのコピー
# COPY ./mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/
# COPY ./conf.d/mysql.cnf /etc/mysql/conf.d/

# CMD ["mysqld"]

# COPY my.cnf /etc/mysql/conf.d/my.cnf