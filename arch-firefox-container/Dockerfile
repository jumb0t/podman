##	Firefox proxychains
##
##
# Используем официальный базовый образ Arch Linux
FROM archlinux:latest



# Устанавливаем необходимые переменные окружения для Pacman и локали
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Обновляем систему и устанавливаем необходимые пакеты
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        firefox \
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
	upower \
	proxychains \
	nano \
	net-tools \
	dnsutils \
	iptables \
    && pacman -Scc --noconfirm



# Генерация локали
RUN sed -i '/en_US.UTF-8/s/^#//g' /etc/locale.gen && \
    locale-gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/locale.conf

# Аргументы для UID и GID
ARG USER_ID=1000
ARG GROUP_ID=1000

USER root
# Создание группы и пользователя с заданным UID и GID
RUN groupadd -g $GROUP_ID firefoxgroup && \
    useradd -m -u $USER_ID -g firefoxgroup -s /bin/bash firefoxuser

# Создание каталога профиля Firefox
RUN mkdir -p /home/firefoxuser/.mozilla/firefox

RUN chown -R firefoxuser:firefoxgroup /home/firefoxuser/.mozilla/firefox
RUN mkdir -p /run/user/1000/dconf
RUN chown -R firefoxuser:firefoxgroup /run/user/1000/dconf
RUN chmod -R 700 /run/user/1000/dconf

# Копирование пользовательского proxychains.conf
COPY proxychains.conf /etc/proxychains.conf


# Установка рабочей директории
WORKDIR /home/firefoxuser


# Переключаемся на непривилегированного пользователя
USER firefoxuser

# Настройка переменных окружения для Wayland и PulseAudio
ENV WAYLAND_DISPLAY=wayland-0
ENV XDG_RUNTIME_DIR=/run/user/1000
ENV MOZ_ENABLE_WAYLAND=1
ENV PULSE_SERVER=unix:/run/pulse/native
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Команда по умолчанию для запуска Firefox через proxychains
CMD ["proxychains", "firefox"]
