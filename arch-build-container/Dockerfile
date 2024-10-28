# Используем официальный базовый образ Arch Linux
FROM archlinux:latest

# Устанавливаем необходимые переменные окружения для Pacman и локали
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Обновляем систему и устанавливаем необходимые пакеты для сборки
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        base-devel \
        git \
        cmake \
        make \
        gcc \
        clang \
        python \
        go \
        nodejs \
        npm \
        rust \
        cargo \
        openssl \
        wget \
        curl \
    && pacman -Scc --noconfirm

# Генерация локали
RUN sed -i '/en_US.UTF-8/s/^#//g' /etc/locale.gen && \
    locale-gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/locale.conf

# Создание непривилегированного пользователя
ARG USER_NAME=builder
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupadd -g $GROUP_ID $USER_NAME && \
    useradd -m -u $USER_ID -g $USER_NAME -s /bin/bash $USER_NAME

# Установка рабочей директории
WORKDIR /home/$USER_NAME/project

# Переключаемся на непривилегированного пользователя
USER $USER_NAME

# Команда по умолчанию для запуска bash
CMD ["bash"]
