# Используем официальный базовый образ Arch Linux
FROM archlinux:latest

USER root

# Устанавливаем необходимые переменные окружения для Pacman и локали
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV QT_QPA_PLATFORM=wayland

# Обновляем систему и устанавливаем необходимые пакеты
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        telegram-desktop \
        dbus \
        xdg-desktop-portal \
        xdg-desktop-portal-gtk \
        mesa \
        xf86-video-amdgpu \
        pulseaudio \
        alsa-lib \
        libxkbcommon \
        libx11 \
        libxcomposite \
        libxdamage \
        libxrandr \
        libxcb \
        libxext \
        gtk3 \
        nss \
        ca-certificates \
        sudo \
        proxychains-ng \
        nano \
	libxcb \
	xcb-util-cursor \
	qt6-xcb-private-headers \
	qt5-xcb-private-headers \
	qt5-wayland \
	qt6-wayland \
	qt5-base \
	qt6-base \
    && pacman -Scc --noconfirm


# Генерация локали
RUN sed -i '/en_US.UTF-8/s/^#//g' /etc/locale.gen && \
    locale-gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/locale.conf

# Аргументы для UID и GID
ARG USER_NAME=tg1
ARG USER_ID=1000
ARG GROUP_ID=1000

# Создание группы и пользователя с заданным UID и GID
RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
    useradd -m -u ${USER_ID} -g ${USER_NAME} -s /bin/bash ${USER_NAME} && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER root

# Создание каталога профиля Telegram
RUN mkdir -p /home/${USER_NAME}/telegram

RUN chown -R tg1:tg1 /home/tg1/telegram

# Копирование пользовательского proxychains.conf
COPY proxychains.conf /etc/proxychains.conf



# Установка рабочей директории
WORKDIR /home/${USER_NAME}



# Переключаемся на непривилегированного пользователя
USER tg1

# Команда по умолчанию для запуска Telegram через proxychains с указанием рабочей директории
CMD ["proxychains", "telegram-desktop", "-tosettings", "-noupdate", "--workdir", "/home/tg1/telegram/"]

#CMD ["bash"]
