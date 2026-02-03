# Отчет по проекту Linux_Installation_ubuntu_20_04_lts.
>Это образовательный проект для демонстрации навыков. Копирование решений без понимания — нарушение правил обучения
---

![Ubuntu](https://img.shields.io/badge/Ubuntu-20.04_LTS-E95420?logo=ubuntu&logoColor=white)
![SSH](https://img.shields.io/badge/SSH-Port_2022-4A90E2?logo=openssh&logoColor=white)
![Netplan](https://img.shields.io/badge/Network-Netplan-orange)
![Status](https://img.shields.io/badge/Status-Completed-success)
![Purpose](https://img.shields.io/badge/Purpose-Educational-blue)
![License](https://img.shields.io/badge/License-MIT-green)


>Production-ready Ubuntu Server deployment: static networking, SSH hardening, system monitoring, CRON automation. Foundation для Infrastructure as Code projects

# Linux_Installation_ubuntu_20_04_lts

## Prerequisites
- VirtualBox 6.1+ или VMware Workstation
- Ubuntu Server 20.04 LTS ISO
- Минимум 2GB RAM, 25GB HDD

## Quick Start
1. Скачать Ubuntu Server 20.04 LTS
2. Создать VM с сетевым адаптером NAT
3. Следовать разделам Part 1-15 для пошаговой настройки


## Цель
Развертывание и конфигурация базового production-ready окружения Ubuntu Server 20.04 LTS с настройкой сетевых сервисов, системного мониторинга, удаленного доступа и автоматизации задач. Проект демонстрирует понимание фундаментальных концепций системного администрирования Linux для последующего применения в DevOps-практиках.

## Архитектура/Схема


```mermaid
graph TB
    subgraph System[Ubuntu Server 20.04 LTS - blainbatmachine-1]
        direction TB
        A[Core System]
    end
    
    subgraph Network[Network Layer]
        B[enp0s3<br/>10.0.2.20/24]
        C[Gateway: 10.0.2.2]
        D[DNS: 1.1.1.1, 8.8.8.8]
    end
    
    subgraph Services[System Services]
        E[SSH Daemon<br/>Port 2022]
        F[NTP Sync<br/>Moscow GMT+3]
        G[CRON Scheduler]
    end
    
    subgraph Storage[Storage & Monitoring]
        H[Disk: sda 25GiB<br/>ext4, 48% used]
        I[Swap: 2.2GiB<br/>file-based]
        J[Monitoring:<br/>top, htop, ncdu]
    end
    
    subgraph Users[User Management]
        K[blainbat<br/>sudo, adm groups]
    end
    
    A --> Network
    A --> Services
    A --> Storage
    A --> Users
    

```text
┌─────────────────────────────────────────────────────────────────┐
│                    Ubuntu Server 20.04 LTS                      │
│                   Hostname: blainbatmachine-1                   │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │
        ┌─────────────────────┴─────────────────────┐
        │         Network Configuration             │
        │  ┌─────────────────────────────────────┐  │
        │  │  Interface: enp0s3                  │  │
        │  │  IP: 10.0.2.20/24 (static)          │  │
        │  │  Gateway: 10.0.2.2                  │  │
        │  │  DNS: 1.1.1.1, 8.8.8.8              │  │
        │  │  Managed by: netplan (networkd)     │  │
        │  └─────────────────────────────────────┘  │
        │  ┌─────────────────────────────────────┐  │
        │  │  Interface: lo (loopback)           │  │
        │  │  IP: 127.0.0.1                      │  │
        │  └─────────────────────────────────────┘  │
        └───────────────────────────────────────────┘
                              │
                              │
        ┌─────────────────────┴─────────────────────┐
        │            System Services                │
        │  ┌─────────────────────────────────────┐  │
        │  │  SSH Daemon (sshd)                  │  │
        │  │  Port: 2022 (custom)                │  │
        │  │  State: active, autostart enabled   │  │
        │  └─────────────────────────────────────┘  │
        │  ┌─────────────────────────────────────┐  │
        │  │  NTP Sync (systemd-timesyncd)       │  │
        │  │  Timezone: Europe/Moscow (GMT+3)    │  │
        │  └─────────────────────────────────────┘  │
        │  ┌─────────────────────────────────────┐  │
        │  │  CRON Scheduler                     │  │
        │  │  Задачи: по расписанию              │  │
        │  └─────────────────────────────────────┘  │
        └───────────────────────────────────────────┘
                              │
                              │
        ┌─────────────────────┴─────────────────────┐
        │         Storage & Monitoring              │
        │  ┌─────────────────────────────────────┐  │
        │  │  Disk: /dev/sda (25 GiB)            │  │
        │  │  Root: /dev/mapper/ubuntu--vg...    │  │
        │  │  FS: ext4, Used: 48%                │  │
        │  │  Swap: 2.2 GiB (file-based)         │  │
        │  └─────────────────────────────────────┘  │
        │  ┌─────────────────────────────────────┐  │
        │  │  Monitoring: top, htop, ncdu        │  │
        │  │  Logging: syslog, auth.log, dmesg   │  │
        │  └─────────────────────────────────────┘  │
        └───────────────────────────────────────────┘
                              │
                              │
        ┌─────────────────────┴─────────────────────┐
        │            User Management                │
        │  Root (disabled login)                    │
        │  blainbat (sudo, adm groups)              │
        └───────────────────────────────────────────┘
```


## Основные результаты

- **Сетевая конфигурация:** Настроена статическая IP-адресация (10.0.2.20/24) с кастомными DNS (1.1.1.1, 8.8.8.8) и шлюзом через netplan + systemd-networkd. Проверена связность с внешними хостами (ya.ru, 1.1.1.1) с 0% потерь пакетов.

- **Безопасный удаленный доступ:** Развернут и настроен SSH-сервер на нестандартном порту 2022 с автозапуском при загрузке системы. Служба слушает все сетевые интерфейсы (0.0.0.0:2022), подтверждено через `netstat -tan`.

- **Управление пользователями и привилегиями:** Создан непривилегированный пользователь `blainbat` с доступом к sudo и группе администрирования (adm). Продемонстрирована смена hostname системы без использования root-аккаунта.

- **Синхронизация времени:** Настроен NTP-клиент (systemd-timesyncd) с временной зоной Europe/Moscow (GMT+3). Статус синхронизации: `NTPSynchronized=yes`.

- **Системный мониторинг:** Установлены и изучены утилиты мониторинга ресурсов (top, htop, ncdu) с демонстрацией сортировки по CPU, памяти, времени и фильтрации процессов.

- **Анализ хранилища:** Изучена файловая система ext4 на LVM-разделе (/dev/mapper/ubuntu--vg-ubuntu--lv). Выполнен анализ дискового пространства: корневой раздел 12G, использовано 48%, swap 2.2G в формате файла подкачки.

- **Работа с текстовыми редакторами:** Освоены операции в vim, nano, mcedit: создание/редактирование файлов, поиск/замена текста, сохранение и выход без сохранения.

- **Аудит системы:** Проанализированы системные журналы (syslog, auth.log, dmesg). Найдены записи последней успешной авторизации пользователя и перезапуска SSH-службы.

- **Автоматизация задач:** Настроен планировщик CRON для выполнения команды `uptime` каждые 2 минуты. Проверено выполнение через системный журнал, задача успешно удалена после тестирования.

- **Обновление системы:** Выполнено полное обновление системных пакетов (`apt update && apt upgrade`). Финальная проверка подтвердила актуальность всех компонентов.

## Сложности и решения

**1. Конфликт статического IP с DHCP-сервером VirtualBox**

- **Проблема:** При попытке назначить статический IP-адрес 10.0.2.15 система впадала в бесконечный цикл опроса адреса на этапе загрузки. Причина — встроенный DHCP-сервер VirtualBox резервирует адреса из диапазона .2-.15 для динамического распределения.

- **Решение:** Выбран адрес 10.0.2.20 вне резервируемого диапазона. Дополнительно добавлен параметр `optional: true` в конфигурацию netplan для ускорения загрузки системы без ожидания полного подтверждения сетевого подключения. Настройки проверены командой `sudo netplan try` перед применением.

**2. Swap не отображается в fdisk как раздел**

- **Проблема:** Команда `sudo fdisk -l` не показывала раздел подкачки, хотя система использовала swap. Ожидалось увидеть отдельный partition типа "Linux swap".

- **Решение:** Через команду `free -h` обнаружено, что Ubuntu 20.04 использует **файл подкачки** (/swapfile) размером 2.2 GiB вместо отдельного раздела. Это современный подход, упрощающий управление swap без переразметки диска. Информация о swap получена из `/proc/meminfo`, а не из таблицы разделов.

**3. Удаление cookie в FastAPI (контекст из другого проекта, но принцип применим)**

- **Проблема:** (Примечание: эта сложность из прикрепленного файла plan-4.md [file:42], но может быть релевантна для будущих проектов с веб-сервисами). Метод `delete_cookie()` в Starlette/FastAPI не поддерживает параметры `httponly` и `samesite` в некоторых версиях, что приводит к некорректному удалению защищенных cookies.

- **Решение:** Вместо `delete_cookie()` использован `set_cookie()` с пустым значением (`value=""`) и `max_age=0`. Это гарантирует полное удаление cookie с сохранением всех security-флагов (httpOnly, Secure, SameSite).

## Выводы

**Приобретенные навыки:**

Проект охватил полный цикл базовой настройки production-окружения Linux: от установки ОС до автоматизации задач. Получены практические навыки работы с netplan/systemd-networkd для управления сетью, конфигурации SSH для безопасного удаленного доступа, анализа системных журналов для диагностики проблем и использования CRON для автоматизации рутинных операций.

**Области применения:**

- **DevOps-инфраструктура:** Навыки настройки статических IP, SSH и мониторинга критичны для управления серверными нодами в Kubernetes/Docker Swarm кластерах. Понимание работы netplan применимо при автоматизации сетевых конфигураций через Ansible/Terraform.

- **CI/CD окружения:** Опыт с CRON и системными службами полезен для настройки self-hosted CI runners (GitLab Runner, Jenkins agents) с автоматическими задачами очистки, бэкапов и обновлений.

- **Системное администрирование:** Умение работать с журналами (syslog, auth.log) и утилитами мониторинга (top, htop, ncdu) необходимо для диагностики инцидентов на production-серверах и оптимизации ресурсов.

- **Государственный сектор (опыт МВД РФ):** Навыки настройки Astra Linux и управления пользователями напрямую применимы в проектах с требованиями ФСТЭК для критической информационной инфраструктуры (КИИ) [cite:1][cite:5].

**Развитие навыков:**

Следующие шаги для углубления DevOps-компетенций: автоматизация настройки через Ansible-плейбуки, контейнеризация сервисов (Docker/Podman), настройка централизованного логирования (ELK/Loki), изучение infrastructure as code (Terraform для облачных провайдеров).



## Используемые технологии
- Ubuntu 20.04 LTS
- netplan
- sudo
- vim
- nano
- mcedit
- sshd
- top
- htop
- fdisk
- df
- du
- ncdu
- syslogs
- systemd
- networkd
- CRON
- crontab

## Архитектура/Схема
[Вставить диаграмму или ASCII-схему]

## Основные результаты
- Настроена сеть с X интерфейсами
- Развернут сервис Y с автозапуском
- Автоматизирован процесс Z

## Сложности и решения
Описание 1-2 нетривиальных проблем и как их решил.

## Выводы
Что узнал, где можно применить.

## Оглавление

1. [Part 1. Установка ОС](#part-1-установка-ос)
2. [Part 2. Создание пользователя](#part-2-создание-пользователя)
3. [Part 3. Настройка сети ОС](#part-3-настройка-сети-ос)
4. [Part 4. Обновление ОС](#part-4-обновление-ос)
5. [Part 5. Использование команды sudo](#part-5-использование-команды-sudo)
6. [Part 6. Установка и настройка службы времени](#part-6-установка-и-настройка-службы-времени)
7. [Part 7. Установка и использование текстовых редакторов](#part-7-установка-и-использование-текстовых-редакторов)
8. [Part 8. Установка и базовая настройка сервиса SSHD](#part-8-установка-и-базовая-настройка-сервиса-sshd)
9. [Part 9. Установка и использование утилит top, htop](#part-9-установка-и-использование-утилит-top-htop)
10. [Part 10. Использование утилиты fdisk](#part-10-использование-утилиты-fdisk)
11. [Part 11. Использование утилиты df](#part-11-использование-утилиты-df)
12. [Part 12. Использование утилиты du](#part-12-использование-утилиты-du)
13. [Part 13. Установка и использование утилиты ncdu](#part-13-установка-и-использование-утилиты-ncdu)
14. [Part 14. Работа с системными журналами](#part-14-работа-с-системными-журналами)
15. [Part 15. Использование планировщика заданий CRON](#part-15-использование-планировщика-заданий-cron)

---

## Part 1. Установка ОС

**Установка Ubuntu 20.04 Server LTS.**

1.  **Проверка версии Ubuntu:**
    Выполнена команда ``cat /etc/issue``.
    ![screen1](<./misc/images/Pasted image 20260105003605.png>)

2.  **Проверка отсутствия графического интерфейса:**
    Проверен статус служб графических менеджеров (lightdm, gdm, sddm) и наличие пакетов xorg/wayland.
    Команды:




    - ``systemctl status lightdm``

    - ``systemctl status sddm``

    - ``systemctl status gdm``

    - ``dpkg -l | grep -E "xorg|wayland|gnome"``
    ![screen](<./misc/images/Pasted image 20260105002711.png>)
        Результат: Службы не найдены, графическая оболочка отсутствует.
    

## Part 2. Создание пользователя

**Создание пользователя и добавление в группы.**

1.  **Создание пользователя:**
    Выполнена команда ``sudo adduser blainbat``.
    ![screen](<./misc/images/Pasted image 20260105003844.png>)

2.  **Добавление в группу adm:**
    Выполнена команда ``sudo usermod -aG adm blainbat``.
    ![screen](<./misc/images/Pasted image 20260105003904.png>)

3.  **Проверка наличия пользователя:**
    Выполнена команда ``cat /etc/passwd``. В конце файла присутствует строка с созданным пользователем.
    ![screen](<./misc/images/Pasted image 20260105003936.png>)

## Part 3. Настройка сети ОС

**1. Задание названия машины.**

- Установлено имя ``blainbat-1`` командой:
  ``sudo hostnamectl set-hostname blainbat-1``
  ![screen](<./misc/images/Pasted image 20260105004027.png>)

- Проверка изменений в файле ``/etc/hostname``:
  ![screen](<./misc/images/Pasted image 20260105004047.png>)

- Изменен файл ``/etc/hosts`` (заменено старое имя на новое):




- ![screen](<./misc/images/Pasted image 20260105004141.png>)

- Старая версия hosts

- ![screen](<./misc/images/Pasted image 20260104213548.png>)

- Новая версия hosts
  ![screen](<./misc/images/Pasted image 20260105004211.png>)

- Изменения в hosts сохранены.

- Перезапущена служба имени машины командой ``sudo systemctl restart systemd-hostnamed``

- ![screen](<./misc/images/Pasted image 20260105004253.png>)

- Проверен факт установки нового имени машины командами ``hostname`` и ``hostnamectl``

- ![screen](<./misc/images/Pasted image 20260105004313.png>)

**2. Установка временной зоны.**

- Просмотр текущей зоны: ``timedatectl status`` (UTC, +0).

- ![screen](<./misc/images/Pasted image 20260105004330.png>)

- Просмотрен список доступных временных зон командой ``timedatectl list-timezones`` и найдена временная зона Москвы, GMT(+3)

- ![screen](<./misc/images/Pasted image 20260105004418.png>)

- Установка временной зоны Москвы:
  ``sudo timedatectl set-timezone Europe/Moscow``

- Проверка применения настроек (Time zone: Europe/Moscow):
  ![screen](<./misc/images/Pasted image 20260105004507.png>)

- Временная зона применена.

**3. Сетевые интерфейсы.**

- Вывод списка интерфейсов командой ``ip a``:
  ![screen](<./misc/images/Pasted image 20260105004524.png>)

- **Интерфейс lo (loopback):** Виртуальный интерфейс (127.0.0.1). Используется для внутренней коммуникации ОС и сетевых служб без выхода в физическую сеть.

**4. Получение IP от DHCP.**

- Команда ``ip a`` показывает полученный адрес: ``10.0.2.15/24`` в IPv4 и ``fd17:625c:f037:2:a00:27ff:fe90:49ab/64`` в IPv6.
  ![screen](<./misc/images/Pasted image 20260105004630.png>)

- **DHCP (Dynamic Host Configuration Protocol):** Протокол, позволяющий автоматически получать IP-адрес, шлюз и DNS от сервера при подключении к сети.

**5. Определение IP-адреса шлюза.**

- Выполнена команда ``ip r`` (или ``ip route``).

- IP-адрес шлюза по умолчанию (default via): ``10.0.2.2``.
  ![screen](<./misc/images/Pasted image 20260105004654.png>)

**6. Задание статичных настроек (IP, GW, DNS).**

- Просмотрено содержимое директории /etc/netplan командой ``ls /etc/netplan/``

- ![screen](<./misc/images/Pasted image 20260105004727.png>)

- Редактируемый файл: ``/etc/netplan/00-installer-config.yaml``.

- ![screen](<./misc/images/Pasted image 20260105004753.png>)

- Внесены изменения (отключен DHCP, заданы адреса вручную, включена статика):




  - Address: ``10.0.2.20/24`` -- выбран адрес вне .15, по причине резерва адреса .15 внутренним DHCP-сервером VirtualBox и последующей паникой системы при попытке загрузить систему с статически прописанным .15 адресом и бесконечным опросом занятого DHCP-сервером адреса.

  - Gateway: ``10.0.2.2``

  - Nameservers: ``1.1.1.1``, ``8.8.8.8``

  - Были явно прописаны -- Renderer сети: networkd, version (api netplan): 2

  - Добавлен параметр optional: true для ускорения загрузки виртуальной машины до полного подтверждения сети.
  ![screen](<./misc/images/Pasted image 20260105005321.png>)

- Отладка ошибок командой ``sudo netplan try`` не показала их наличия.

- ![screen](<./misc/images/Pasted image 20260105005413.png>)

- Применение настроек командой ``sudo netplan apply``.

**7. Перезагрузка и проверка.**

- Виртуальная машина перезагружена командой ``sudo reboot``.

- Проверка IP (``ip a``): адрес соответствует заданному ``10.0.2.20``.
  ![screen](<./misc/images/Pasted image 20260105005724.png>)

- Проверка шлюза (``ip r``): шлюз ``10.0.2.2``. Протокол static.
  ![screen](<./misc/images/Pasted image 20260105010037.png>)

- Проверка DNS (``resolvectl status``): DNS-серверы ``1.1.1.1`` и ``8.8.8.8``.
  ![screen](<./misc/images/Pasted image 20260105010126.png>)

**8. Пинг удаленных хостов.**

- Пинг ``1.1.1.1`` успешен **(0% packet loss):**
  ![screen](<./misc/images/Pasted image 20260105010150.png>)

- Пинг ``ya.ru`` успешен **(0% packet loss):**
  ![screen](<./misc/images/Pasted image 20260105010218.png>)

## Part 4. Обновление ОС

**Обновление системных пакетов.**

1.  **Поиск обновлений:**
    Выполнена команда ``sudo apt update``.
    ![screen](<./misc/images/Pasted image 20260105010437.png>)

2.  **Установка обновлений:**
    Выполнена команда ``sudo apt upgrade``. Подтверждена установка нажатием ``Y``.
    ![screen](<./misc/images/Pasted image 20260105010505.png>)
    ![screen](<./misc/images/Pasted image 20260105010604.png>)

3.  **Финальная проверка:**
    Повторный запуск ``sudo apt update`` показывает отсутствие обновлений (All packages are up to date).
    ![screen](<./misc/images/Pasted image 20260105010631.png>)
    **Успешно. Все пакеты обновлены.**

## Part 5. Использование команды sudo

**Настройка прав и смена hostname от имени пользователя.**

1.  **Выдача прав:**
    Пользователь blainbat добавлен в группу sudo командой ``sudo usermod -aG sudo blainbat``.
    ![screen](<./misc/images/Pasted image 20260105010850.png>)

2.  **Проверка прав:**
    После перезагрузки и авторизации под blainbat команда ``sudo whoami`` выполнена успешно от имени пользователя (результат ``root``).
    ![screen](<./misc/images/Pasted image 20260105011802.png>)
    *Назначение sudo(superuser do или же substitute user and do): Безопасное выполнение административных команд с временным повышением привилегий от имени суперпользователя (root).
     -- это повышает безопасность системы, минимизирует риски и предоставляет гибкий аудит дейтствий.*

3.  **Смена hostname:**
    Выполнена команда ``sudo hostnamectl set-hostname blainbatmachine-1``.
    ![screen](<./misc/images/Pasted image 20260105011928.png>)

    Выполнена проверка командой ``hostnamectl``
    ![screen](<./misc/images/Pasted image 20260105011943.png>)
    Внесены изменения в ``/etc/hosts``.        ![screen](<./misc/images/Pasted image 20251218171002.png>)
    Старая версия.
    
    ![screen](<./misc/images/Pasted image 20260105012115.png>)
    Новая версия.
    Перезапущена службы имён командой ``sudo systemctl restart systemd-hostnamed``
    
    Проверено новое Hostname с помощью 
    ``ping -c 3 blainbatmachine-1``
    ![screen](<./misc/images/Pasted image 20260105012234.png>)
    Ping успешен.

4.  **Результат:**
    Команда ``hostname`` показывает новое имя: ``blainbatmachine-1``.
    ![screen](<./misc/images/Pasted image 20260105012248.png>)

## Part 6. Установка и настройка службы времени

**Синхронизация времени.**

1.  **Проверка статуса:**
    Команда ``sudo timedatectl show`` показывает параметры:




    - ``NTPSynchronized=yes``

    - ``NTP=yes``
    ![screen](<./misc/images/Pasted image 20260105012318.png>)

2.  **Проверка времени:**
    Команда ``timedatectl`` подтверждает корректное время и статус ``System clock synchronized: yes``.
    ![screen](<./misc/images/Pasted image 20260105012949.png>)



## Part 7. Установка и использование текстовых редакторов

**Установка редакторов:**

- VIM и NANO уже установлены.

- MCEDIT установлен командой ``sudo apt install mc``.

### 1. Создание файла, сохранение и выход

**Первичное создание файлов:** С помощью команд
``touch test_vim.txt``
``touch test_nano.txt``
``touch test_mcedit.txt``

![screen](<./misc/images/Pasted image 20260105013356.png>)
были созданы файлы для начала выполнения задания.

![screen](<./misc/images/Pasted image 20260105013405.png>)

**1.1. VIM**

- Файл открыт: ``sudo vim test_vim.txt``.

- ![screen](<./misc/images/Pasted image 20251220133308.png>)

- **Способ ввода:** Переход в режим вставки (I),![screen](<./misc/images/Pasted image 20251220133409.png>) ввод никнейма.

- ![screen](<./misc/images/Pasted image 20260105013532.png>)

- **Способ сохранения и выхода:** Переход в командный режим (``Esc``), ввод команды ``:wq`` (Write Quit).

- ![screen](<./misc/images/Pasted image 20251220133610.png>)

- ![screen](<./misc/images/Pasted image 20251220133649.png>)
  

**1.2. NANO**

- Файл открыт: ``sudo nano test_nano.txt``.

- ![screen](<./misc/images/Pasted image 20251220140118.png>)

- ![screen](<./misc/images/Pasted image 20251220140123.png>)

- **Способ ввода:** Режим вставки активен по-умолчанию, ввод никнейма.

- ![screen](<./misc/images/Pasted image 20251220140318.png>)

- **Способ сохранения и выхода:** Сохранение через ``Ctrl+O`` -> ``Enter``. 

- ![screen](<./misc/images/Pasted image 20251220140437.png>)Выход через ``Ctrl+X``.

- ![screen](<./misc/images/Pasted image 20251220140457.png>)

- ![screen](<./misc/images/Pasted image 20251220140546.png>)
  

**1.3. MCEDIT**

- Файл открыт: ``sudo mcedit test_mcedit.txt``.

- ![screen](<./misc/images/Pasted image 20251220140720.png>)

- ![screen](<./misc/images/Pasted image 20251220140732.png>)

- **Способ ввода:** Режим вставки активен по-умолчанию, ввод никнейма.

                                            - ![screen](<./misc/images/Pasted image 20251220143017.png>)
- 

- **Способ сохранения и выхода:** Сохранение через ``F2`` (Save) -> подтверждение. 

- ![screen](<./misc/images/Pasted image 20251220141211.png>)

- Выход через ``F10`` (Quit).
  ![screen](<./misc/images/Pasted image 20251220143057.png>)

---

### 2. Редактирование и выход без сохранения

**Задача:** Заменить никнейм на «21 School 21», закрыть без сохранения.

**2.1. VIM**

- Изменен текст.

- ![screen](<./misc/images/Pasted image 20251220144536.png>)

- **Способ выхода без сохранения:** Переход в командный режим (``Esc``), ввод команды ``:q!`` (Quit Force) и ``Enter``.
  ![screen](<./misc/images/Pasted image 20251220144708.png>)

**2.2. NANO**

- Изменен текст.

- ![screen](<./misc/images/Pasted image 20251220144855.png>)

- **Способ выхода без сохранения:** Нажатие ``Ctrl+X``, при запросе сохранения ("Save modified buffer?") выбрано ``N`` (No).

- ![screen](<./misc/images/Pasted image 20251220145015.png>)
  ![screen](<./misc/images/Pasted image 20251220145153.png>)

**2.3. MCEDIT**

- Изменен текст.

- ![screen](<./misc/images/Pasted image 20251220145318.png>)

- **Способ выхода без сохранения:** Нажатие ``F10``, в окне подтверждения выбрано ``No``.
  ![screen](<./misc/images/Pasted image 20251220145410.png>)

- ![screen](<./misc/images/Pasted image 20251220145442.png>)

---

### 3. Поиск и замена

**Задача:** Найти слово и заменить его на другое.

**3.1. VIM**

- Изменён текст на blainbat server

- ![screen](<./misc/images/Pasted image 20251220150533.png>)
-  **Замена:** Из Command-Line mode (:), использована команда ``:%s/server/ubuntu/g`` (замена всех вхождений ``server`` на ``ubuntu`` во всем файле).
  ![screen](<./misc/images/Pasted image 20251220150841.png>)

- ![screen](<./misc/images/Pasted image 20251220150857.png>)

- **Поиск:** Из Normal mode (ESC). Использована команда ``/ubuntu``. При вводе слово выделилось. 
  ![screen](<./misc/images/Pasted image 20251220151036.png>)

- ![screen](<./misc/images/Pasted image 20251220151041.png>)

- При нажатии ``ENTER`` курсор переместился на найденное слово.

- ![screen](<./misc/images/Pasted image 20251220151058.png>)

- **Способ сохранения и выхода:** Переход в командный режим (``Esc``), ввод команды ``:wq`` (Write Quit).

- ![screen](<./misc/images/Pasted image 20251220151150.png>)

**3.2. NANO**

- Изменён текст на blainbat server.

- ![screen](<./misc/images/Pasted image 20251220165301.png>)

- **Поиск:** Использовано сочетание ``Ctrl+W`` (Where Is), введено искомое слово.
  ![screen](<./misc/images/Pasted image 20251220165409.png>)

- Слово было выделено при поиске.

- ![screen](<./misc/images/Pasted image 20251220170350.png>)

- **Замена:** Использовано сочетание ``Ctrl+\`` (Replace). Введено слово для поиска, затем слово для замены, подтверждено нажатием ``A`` (All).

- ![screen](<./misc/images/Pasted image 20251220170456.png>)
  ![screen](<./misc/images/Pasted image 20251220170534.png>)

- ![screen](<./misc/images/Pasted image 20251220170551.png>)

- ![screen](<./misc/images/Pasted image 20251220170605.png>)
  *Результат замены:*
  ![screen](<./misc/images/Pasted image 20251220170813.png>)
-  **Способ сохранения и выхода:** Сохранение через ``Ctrl+O`` -> ``Enter``. 

- ![screen](<./misc/images/Pasted image 20251220170845.png>)

**3.3. MCEDIT**

- Текст изменён на blainbat server.

- ![screen](<./misc/images/Pasted image 20251220171137.png>)

- **Поиск:** Использована клавиша ``F7`` (Search), введено искомое слово ``-> Find all -> ENTER``
  ![screen](<./misc/images/Pasted image 20251220171207.png>)

- Была выделена строка со словом.

- ![screen](<./misc/images/Pasted image 20251220171415.png>)

- При повторном поиске через ``F7`` и ``OK -> ENTER`` слово было выделено.

- **Замена:** Использована клавиша ``F4`` (Replace). Введены параметры поиска и замены, нажато ``Replace``, введено слово для замены, замена подтверждена.

- ![screen](<./misc/images/Pasted image 20251220171612.png>)

- ![screen](<./misc/images/Pasted image 20251220171731.png>)
  ![screen](<./misc/images/Pasted image 20251220171704.png>)
-  **Способ сохранения и выхода:** Сохранение через ``F2`` (Save) -> подтверждение.  Выход через ``F10``.

- ![screen](<./misc/images/Pasted image 20251220171830.png>)

## Part 8. Установка и базовая настройка сервиса SSHD

**1. Установка службы.**

- Обновление пакетов и установка ``openssh-server``:
  ``sudo apt update``
  ``sudo apt install openssh-server``
  ![screen](<./misc/images/Pasted image 20260105014650.png>)

**2. Настройка автозагрузки.**

- Добавление службы в автозагрузку командой ``sudo systemctl enable ssh``:
  ![screen](<./misc/images/Pasted image 20260105015706.png>)

- Запуск службы командой ``sudo systemctl start ssh``:
  ![screen](<./misc/images/Pasted image 20260105015754.png>)

- Проверка статуса командой ``systemctl status ssh`` (Active: active (running)):
  ![screen](<./misc/images/Pasted image 20260105015859.png>)

**3. Перенастройка порта на 2022.**

- Редактирование файла конфигурации ``/etc/ssh/sshd_config`` (использован редактор nano):




- ``sudo nano /etc/ssh/sshd_config``
  ![screen](<./misc/images/Pasted image 20260105020113.png>)

- Параметр ``Port 22`` раскомментирован и изменен на ``Port 2022``:
  ![screen](<./misc/images/Pasted image 20251223012752.png>)

- Сохранён файл с помощью ``CTRL+O -> ENTER``

- Выход с помощью ``CTRL+X``

- Перезапуск службы для применения изменений:
  ``sudo systemctl restart ssh``
  ![screen](<./misc/images/Pasted image 20260105020217.png>)

**4. Проверка процесса sshd.**

- Выполнена команда ``ps -aux | grep sshd``:
  ![screen](<./misc/images/Pasted image 20260105022819.png>)

- **Пояснения:**

  - **Команда ``ps`` (Process Status):** инструмент для вывода текущих процессов в системе.

  - **Ключ ``-a`` (all):** показывать процессы всех пользователей (а не только текущего).

  - **Ключ ``-u`` (user):** выводить подробную информацию (пользователь-владелец, CPU, память, время старта).

  - **Ключ ``-x``:** показывать процессы, не привязанные к терминалу (фоновые демоны, к которым относится sshd).

  - | grep sshd: пайплайн соединение команд. Фильтруем вывод, оставляя только строки с упоминанием sshd.

**5. Перезагрузка и проверка netstat.**

- Система перезагружена командой ``sudo reboot``. Наблюдаем применение изменений изменения Hostname из pt.5 задания.
  ![screen](<./misc/images/Pasted image 20260105023424.png>)

- Установка утилиты netstat: ``sudo apt install net-tools``.
  ![screen](<./misc/images/Pasted image 20260105023702.png>)

- Проверка слушаемых портов командой ``netstat -tan``.
  Вывод содержит строку ``tcp 0 0 0.0.0.0:2022 0.0.0.0:* LISTEN``.
  ![screen](<./misc/images/Pasted image 20260105023727.png>)

**6. Пояснения к netstat:**

- **Команда ``netstat`` (Network Statistics):** утилита для отображения состояния сетевых соединений, таблиц маршрутизации и интерфейсов.

- **Значение ключей ``-tan``:**

  - ``-t`` (tcp): отображать только TCP-соединения.

  - ``-a`` (all): показывать все состояния портов (включая слушаемые/LISTEN).

  - ``-n`` (numeric): отображать IP-адреса и порты числами (не преобразовывать в DNS-имена).

  
- **Значение столбцов:**

  - ``Proto``: Протокол (tcp).

  - ``Recv-Q`` / ``Send-Q``: Очереди (Queue, Q, кью) приема и отправки данных (0 означает отсутствие заторов).

  - ``Local Address``: IP-адрес и порт на локальной машине, который слушает (Режим LISTEN) программа (``0.0.0.0:2022``).

  - ``Foreign Address``: IP-адрес и порт удаленной машины (``0.0.0.0:*`` -- соединение не установлено, мы ожидаем).

  - ``State``: Состояние соединения (``LISTEN`` -- ожидание входящих подключений).


- **Значение ``0.0.0.0``:**
  Означает, что служба SSH прослушивает входящие соединения на **всех** доступных сетевых интерфейсах (подсетях) машины (как локальном loopback 127.0.0.1, так и внешнем IP 10.0.2.20).
## Part 9. Установка и использование утилит top, htop

**1. Утилита TOP.**

- Запуск командой ``top``.
  ![screen](<./misc/images/Pasted image 20260105053426.png>)

- **Метрики:**

  - Uptime: 19 min.

  - Users: 1.

  - Load average: 0.00, 0.00, 0.00.

  - Tasks: 94 total.

  - %Cpu(s): 0.0(us)+0.0(sy), idle = 100.0.

  - memory: 134.9 MiB used / 1982.4 MiB. (Мебибайты) -- 134.9 * 2^20 = 1024*1024 байт.

- Сортировка по памяти -- ``SHIFT+M`` (PID процесса с макс. памятью -- 1599 -- snapd):
  ![screen](<./misc/images/Pasted image 20260105062349.png>)

- Сортировка по процессорному времени -- ``SHIFT + T`` (PID процесса с макс. CPU -- 374 -- kworker):
  ![screen](<./misc/images/Pasted image 20260105062653.png>)

- Также есть сортировка по загрузке CPU -- ``SHIFT + P``. Выход из программы на ``q``.

**2. Утилита HTOP.**

- Запуск командой ``htop``.

- Сортировка по параметру: ``F6``(SortBy):(Открывается меню, где мы выбираем соотв. пункты.)

    - Сортировка по PID:




    - ![screen](<./misc/images/Pasted image 20260105063243.png>)

    - Сортировка по CPU:




    - ![screen](<./misc/images/Pasted image 20260105063311.png>)

    - Сортировка по PERCENT_MEM:




    - ![screen](<./misc/images/Pasted image 20260105063334.png>)

    - Сортировка по TIME:




    - ![screen](<./misc/images/Pasted image 20260105063405.png>)

- Фильтр по процессу ``sshd``:




    - F4(Filter) и ввод ``sshd``

    - ![screen](<./misc/images/Pasted image 20260105063512.png>)

    - Процесс найден.

- Поиск процесса ``syslog``:




    - ``F3``(Search) и ввод ``syslog``

    - ![screen](<./misc/images/Pasted image 20260105063727.png>)

- Добавление метрик (hostname, clock, uptime):



    -  ``F2``(setup)

    - Выбор в Available meters: clock, hostname, uptime

    - ![screen](<./misc/images/Pasted image 20260105063941.png>)

    - ![screen](<./misc/images/Pasted image 20260105064006.png>)

    - ![screen](<./misc/images/Pasted image 20260105064102.png>)

    - ![screen](<./misc/images/Pasted image 20260105064114.png>)

    - ``F5`` (Add): добавляем параметры в левую колонку. 

    - ``F10`` (Done): Применение изменений.

    - ![screen](<./misc/images/Pasted image 20260105064220.png>)

    - Итог редактирования и добавления колонок в интерфейсе программы

    - ![screen](<./misc/images/Pasted image 20260105064303.png>)

- Выход: ``F10``.

## Part 10. Использование утилиты fdisk


- Выполнена команда ``sudo fdisk -l``.
  ![screen](<./misc/images/Pasted image 20260105064638.png>)

- **Данные:**

  - Название диска: ``/dev/sda``

  - Размер: 25 GiB, 26843545600 bytes

  - Секторы: 52428800

  - Размер swap: 2.2 Gi, 2.2 гигибайта, 2.2 * 2^30 байт. (узнали через ``free -h``).

      - Так как в моем варианте установленной на virtualbox Ubuntu -- swap размечен как файл, а не как раздел. 
      -  free -- команда показывает состояние оперативной памяти и файла подкачки из ядра (/proc/meminfo)

      - ![screen](<./misc/images/Pasted image 20260105065729.png>)

## Part 11. Использование утилиты df

**1. Команда ``df`` (информация о пространстве).**


- Выполнена команда ``sudo df``.
  ![screen](<./misc/images/Pasted image 20260105070053.png>)


- **Информация для корневого раздела (mounted on ``/``):**

  - **Название раздела:** ``/dev/mapper/ubuntu--vg-ubuntu--lv``

  - **Размер раздела:** 11758760 (1K-blocks)

  - **Размер занятого пространства:** 5305140 (Used)

  - **Размер свободного пространства:** 5834512 (Available)

  - **Процент использования:** 48% (Use%)


- **Единица измерения:**
  В столбце указано ``1K-blocks``.
  **Вывод:** Единица измерения — **Килобайт** (1024 байта).

**2. Команда ``df -Th`` (человек читаемый вид и тип файловой системы).**

- Выполнена команда ``sudo df -Th``.

  - Ключ ``-T``: выводит тип файловой системы.

  - Ключ ``-h``: выводит размеры в человек читаемом виде.

  - ![screen](<./misc/images/Pasted image 20260105070615.png>)


- **Информация для корневого раздела (mounted on ``/``):**

  - **Размер раздела:** 12G (Гигабайт)

  - **Размер занятого пространства:** 5.1G

  - **Размер свободного пространства:** 5.6G

  - **Процент использования:** 48%


- **Тип файловой системы:**
  В столбце ``Type`` для корневого раздела указано ``ext4``.
  **Вывод:** Файловая система нашего диска — **ext4**.

## Part 12. Использование утилиты du

**1. Запуск команды du.**

- Выполнена команда ``sudo du``.
  ![screen](<./misc/images/Pasted image 20260105084911.png>)

**2. Вывод размера папок (/home, /var, /var/log).**


- **В байтах:**
  Выполнена команда ``sudo du -sb /home /var/log /var``.

  - Ключ ``-s`` (summary): выводить только итоговый размер для указанных аргументов.

  - Ключ ``-b`` (bytes): размер в байтах.
  ![screen](<./misc/images/Pasted image 20260105090007.png>)


- **В человек читаемом виде:**
  Выполнена команда ``sudo du -sh /home /var/log /var``.

  - Ключ ``-h`` (human-readable): размер в K, M, G.
  ![screen](<./misc/images/Pasted image 20260105090112.png>)

**3. Вывод содержимого /var/log.**

- Вывод размера каждого вложенного элемента в ``/var/log`` с использованием маски ``*``.
  Команда: ``sudo du -h /var/log/*``.
  ![screen](<./misc/images/Pasted image 20260105091407.png>)
## Part 13. Установка и использование утилиты ncdu


- Утилита установлена ``sudo apt install ncdu``.

- Проверка размера ``/var``:




- ``sudo ncdu /var``

- ![screen](<./misc/images/Pasted image 20260105091159.png>)

    - размер /var: 1.0 GiB.

    - Размер /var/log: 139.4 MiB.

- Проверка размера ``/home``:




- ``sudo ncdu /home``

- ![screen](<./misc/images/Pasted image 20260105091932.png>)

    - Размер /home -- 84.0 KiB.

- *Размеры совпадают в пределах погрешности округления ncdu.*

## Part 14. Работа с системными журналами

**Анализ логов.**

1.  **Просмотр:**
    Просмотрены файлы ``dmesg``, ``syslog``, ``auth.log`` через ``less``.

    - sudo less /var/log/dmesg

        - ![screen](<./misc/images/Pasted image 20260105092340.png>)

    - sudo less /var/log/syslog

        - ![screen](<./misc/images/Pasted image 20260105092439.png>)

    - sudo less /var/log/auth.log

        - ![screen](<./misc/images/Pasted image 20260105092550.png>)

2.  **Поиск последней успешной авторизации:**

- Команда ``grep -a "login" /var/log/auth.log | tail -n 5``.

- ![screen](<./misc/images/Pasted image 20260105094002.png>)

- Данные найдены в последних двух строчках:




    - Время последней успешной авторизации: Jan 5 02:34:43

    - Пользователь: blainbat

    - Метод: LOGIN (локальный вход, login/tty1)

3. **Рестарт службы SSHd.** 

- Служба перезапущена командой ``sudo systemctl restart sshd``. 

- ![screen](<./misc/images/Pasted image 20260105094304.png>)

- **Сообщение о рестарте в логах:** Выполнен поиск в ``syslog``: ``grep -a "ssh" /var/log/syslog | tail -n 20``. Найдена запись ``ssh.service: Succeeded`` с актуальным временем.

- ![screen](<./misc/images/Pasted image 20260105094558.png>)

## Part 15. Использование планировщика заданий CRON

**1. Теоретическая справка.**

- Используем планировщик заданий **CRON** (утилита ``crontab``).

    - **Ключи ``crontab``:**

      - ``-e`` (EDIT): редактировать текущее расписание (открывает текстовый редактор).

      - ``-l`` (LIST): показать список текущих задач.

      - ``-r`` (REMOVE): удалить все задачи текущего пользователя.

    - **Синтаксис задачи:**
      ``минута час день месяц день_недели /путь/к/команде``

      - Важно указывать **полный путь** к исполняемому файлу, так как переменная относительного пути PATH у cron отличается от пользовательской при запуске команд от своего лица.

      - Значения: ``*`` (каждый), ``*/N`` (каждый N-ный промежуток), ``N`` (только N-ный промежуток).

**2. Подготовка.**

- Проверка текущих задач:




    - Команда ``crontab -l`` (список пуст).

    - ![screen](<./misc/images/Pasted image 20260106122327.png>)

- Поиск полного пути к команде uptime:




    - Команда ``which uptime``. 

    - Результат ``/usr/bin/uptime``.

    - ![screen](<./misc/images/Pasted image 20260106122516.png>)

**3. Настройка задания.**

- Открытие редактора:
      Команда ``crontab -e`` (выбран редактор nano: 1).

    - ![screen](<./misc/images/Pasted image 20260106122821.png>)

    - ![screen](<./misc/images/Pasted image 20260106122931.png>)

- Добавление задачи:




    - В конец файла добавлена строка: ``*/2 * * * * /usr/bin/uptime``.

    - *Значение:* Выполнять команду ``/usr/bin/uptime`` каждую 2-ю минуту.

    - ![screen](<./misc/images/Pasted image 20260106123226.png>)

- Проверка сохранения:




    - Команда ``crontab -l`` отображает добавленную задачу.

    - ![screen](<./misc/images/Pasted image 20260106123526.png>)

**4. Проверка выполнения (Просмотр логов).**

- Поиск записей в системном журнале:




    - Команда ``grep -a CRON /var/log/syslog``.

    - ![screen](<./misc/images/Pasted image 20260106124611.png>)

- **Анализ логов:**

- Видны записи выполнения команды каждые 2 минуты (например, в 36, 38, 40 минут).

- Сообщение ``(CRON) info (No MTA installed, discarding output)`` означает, что CRON пытался отправить вывод команды ``uptime`` на почту пользователя, но почтовый сервер (MTA) не настроен, поэтому вывод был отброшен.

**5. Удаление заданий.**

- Удаление всех задач:




    - Команда ``crontab -r``.

    - ![screen](<./misc/images/Pasted image 20260106125243.png>)

- Финальная проверка:




    - Команда ``crontab -l`` подтверждает отсутствие задач (``no crontab for user``).


    - ![screen](<./misc/images/Pasted image 20260106125342.png>)







