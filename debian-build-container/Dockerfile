# Используем официальный базовый образ Debian для архитектуры amd64
FROM debian:latest

# Устанавливаем необходимые переменные окружения для APT и локали
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Обновляем систему и устанавливаем необходимые пакеты для сборки
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        cmake \
        make \
        gcc \
        g++ \
        clang \
        python3 \
        python3-pip \
        golang \
        nodejs \
        npm \
        rustc \
        cargo \
        wget \
        curl \
        ca-certificates \
        sudo \
        nano \
	libz-dev \
	libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Генерация локали
RUN apt-get update && \
    apt-get install -y locales && \
    sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/locale.conf && \
    rm -rf /var/lib/apt/lists/*

# Аргументы для UID и GID
ARG USER_NAME=builder
ARG USER_ID=1000
ARG GROUP_ID=1000

# Создание группы и пользователя с заданным UID и GID
RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
    useradd -m -u ${USER_ID} -g ${USER_NAME} -s /bin/bash ${USER_NAME} && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Установка рабочей директории
WORKDIR /home/${USER_NAME}/project

# Переключаемся на непривилегированного пользователя
USER ${USER_NAME}

# Установка pip для пользователя
RUN python3 -m pip install --break-system-packages --user --upgrade pip

# Команда по умолчанию для запуска bash
CMD ["bash"]
