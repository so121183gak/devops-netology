# Введение в виртуализацию

### 1. Задача
- Основные приемущества применения **IaaC** паттернов это беспрерывная интеграция **CI** она позволяет нам осуществлять автоматическую сборку продуктов и организовывать тестирования сразу после попадания кода в нужной ветке репазитория, что сказывается на снижение уровня рутины и выявлению проблем и устранения их на ранних стадиях. Беспрерывная доставка **CD**(Delivery) позволяет нам развернуть наше собранное приложение в ручном режиме (Подтверждение), такой метод позволяет более контролируемо заливать новые версии в production среду. Беспрерывное Развертывание **CD** (Deployment) позволяет автоматически развертывать приложение в люубую среду, но как правило используется в develop и stage средах. Все вместе эти паттерны выстраиваются в конвеер и организовывают систему полного  жизненного цикла разработки ПО.
- Основополагающий принцип **IaaC** это **Идемпотентность** по сути благодаря этому свойству мы можем многократно повторять операции и получать одинаковый результат. Примером может служить развертование нужного ПО на удаленных серверах по средством ansible. Мы можем развернуть nginx на пяти серверах используя одну команду.

### 2. Задача
- **высоконагруженное монолитное Java веб-приложение** в случае монолитного приложения, которое высоконагруженно не всегда хорошо подходит **docker**, так как **docker** хорошо подходит для приложений которые дробятся на микро сервисы. Для такого приложения подойдет хорошо подойдет **полная аппаратная виртуализация** так как ресурсы в нашем случае будут критичны, такой подход нивелирует эти проблемы и даст гибкость в использовании, в виде резервного копирования и балансировки нагрузки. 
- **Nodejs веб-приложение** в данном случае docker отлично подойдет, мы можем использовать контейнеры с node js и организовать микросервисную архитектуру используя например **docker** или **docker-compose**.
- **мобильное приложение c версиями для Android и iOS** в данном случае **docker** не всегда подходит для сборки приложения, хотя бывают варианты что его можно использовать для этого, если например сделать специальные образы со средой сборки и держать их в **regestry**. Все же для таких задач на мой взгляд лучше использовать виртуальные машины **паравиртуализацию**, это позволило бы лучше проходить стадии отладки и сборки приложений, так как среда сборки для приложений такого типа может часто меняться.
- **шина данных на базе Apache Kafka** честно говоря мало знаю об этой технологии, но из того что мне известно, я бы разврнул его в кластере **Kubernetes**, с использованием **docker** все дело в том что этот инструмент, я вно заточен на микросервистную. архитектуру на мой взгляд.
- **Elasticsearch-кластер** На мой взгляд такой сервис тоже можно развернуть с использованием **docker** в зависимости от масштабов использовать **docker-compose** или **Kubernetes**. 
- **мониторинг-стек на базе Prometheus и Grafana** в данном случае я бы использовал виртуальную машину **паравиртуализацию**, та как в принципе мониторинг может быть поднят где угодно и интегрирован с любой системой, пускай это будет монолит или микросервисная архитектура.
- **MongoDB как основное хранилище данных для Java-приложения** В данном случае я бы посмотрел где крутиться Java приложение и исходя из этого принимал решение где лучше развернуть **MongoDB**, потому как нужно было бы обеспечить консистентность среды и не городить велосипеды. 
- **Gitlab-сервер для реализации CI/CD-процессов и приватный (закрытый) Docker Registry**, я бы развернул такую связку используя **docker-compose**, это бы позволило, обеспечить гибкость при обслуживании и последующей модификации такой системы.


### 3. Задача
- листинг содержимого из папки data контейнера debian
```
root@0324bddef388:/data# ls
testCentos.txt  testPC.txt
```
- содержимое файлов
```
root@0324bddef388:/data# cat testCentos.txt 
Netology test for Centos

root@0324bddef388:/data# cat testPC.txt 
Netology test for host PC
```


### 4. Задача
- Так как у меня **ansible** 2.14.2 пришлось добавить в **Vagrantfile**  директиву которая делает его совместимым с моей версией **ansible**
```
setup.compatibility_mode = "2.0"
```
```
vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
==> server1.netology: Matching MAC address for NAT networking...
==> server1.netology: Checking if box 'bento/ubuntu-20.04' version '202303.13.0' is up to date...
==> server1.netology: Setting the name of the VM: server1.netology
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 127.0.0.1:2222
    server1.netology: SSH username: vagrant
    server1.netology: SSH auth method: private key
    server1.netology: 
    server1.netology: Vagrant insecure key detected. Vagrant will automatically replace
    server1.netology: this with a newly generated keypair for better security.
    server1.netology: 
    server1.netology: Inserting generated public key within guest...
    server1.netology: Removing insecure key from the guest if it's present...
    server1.netology: Key inserted! Disconnecting and reconnecting using new SSH key...
==> server1.netology: Machine booted and ready!
==> server1.netology: Checking for guest additions in VM...
==> server1.netology: Setting hostname...
==> server1.netology: Configuring and enabling network interfaces...
==> server1.netology: Mounting shared folders...
    server1.netology: /vagrant => /home/fabryan/stady/netology/lesson6/vagrant
==> server1.netology: Running provisioner: ansible...
    server1.netology: Running ansible-playbook...
 ______________
< PLAY [nodes] >
 --------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

 ________________________
< TASK [Gathering Facts] >
 ------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

ok: [server1.netology]
 ______________________________________
< TASK [Create directory for ssh-keys] >
 --------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

ok: [server1.netology]
 _____________________________________________________
< TASK [Adding rsa-key in /root/.ssh/authorized_keys] >
 -----------------------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

changed: [server1.netology]
 _____________________
< TASK [Checking DNS] >
 ---------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

changed: [server1.netology]
 _________________________
< TASK [Installing tools] >
 -------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

ok: [server1.netology] => (item=git)
ok: [server1.netology] => (item=curl)
 __________________________
< TASK [Installing docker] >
 --------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

changed: [server1.netology]
 _____________________________________________
< TASK [Add the current user to docker group] >
 ---------------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

changed: [server1.netology]
 ____________
< PLAY RECAP >
 ------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

server1.netology           : ok=7    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

