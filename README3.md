# Введение в виртуализацию

### 1. Задача
- Основные приемущества применения **IaaC** паттернов это беспрерывная интеграция **CI** она позволяет нам осуществлять автоматическую сборку продуктов и организовывать тестирования сразу после попадания кода в нужной ветке репазитория, что сказывается на снижение уровня рутины и выявлению проблем и устранения их на ранних стадиях. Беспрерывная доставка **CD**(Delivery) позволяет нам развернуть наше собранное приложение в ручном режиме (Подтверждение), такой метод позволяет более контролируемо заливать новые версии в production среду. Беспрерывное Развертывание **CD** (Deployment) позволяет автоматически развертывать приложение в люубую среду, но как правило используется в develop и stage средах. Все вместе эти паттерны выстраиваются в конвеер и организовывают систему полного  жизненного цикла разработки ПО.
- Основополагающий принцип **IaaC** это **Идемпотентность** по сути благодаря этому свойству мы можем повторять многократно повторять операции и получать одинаковый результат. Примером может служить развертование нужного ПО на удаленных серверах по средством ansible. Мы можем развернуть nginx на пяти серверах используя одну команду.

### 2. Задача
- **Ansible** имеет низкий порог входа с точки зрения развертывания на удаленых серверах, все что ему нужно это доступ по протоколу **SSH**, так же он довольно быстрый и можно подключить многочисленные модули. Не могу не написать про то что **Ansible** хорошо задокументированн.
- На мой взгляд работа вс системами конфигураций надежнее работает метод **push**, так как мы контролируем инициацию процесса, в такой связке проще на мой взгляд выявить ошибки и решить их. Особенно такой метод будет актуален в тех проектах где еще нет мониторинга, либо он не покрывает всю инфраструктуру.

### 3. Задача
```
virtualbox --help
Oracle VM VirtualBox VM Selector v7.0.6_Ubuntu<br>
Copyright (C) 2005-2023 Oracle and/or its affiliates<br>

No special options.

If you are looking for --startvm and related options, you need to use VirtualBoxVM
```
```
vagrant -v
Vagrant 2.3.7
```
```
terraform -v
Terraform v1.5.1
on linux_amd64
```
```
ansible --version
ansible [core 2.14.2]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/fabryan/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/fabryan/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.11.2 (main, May 30 2023, 17:45:26) [GCC 12.2.0] (/usr/bin/python3)
  jinja version = 3.1.2
  libyaml = True
```
### 4. Задача
- Так как у меня **ansible** 2.14.2 пришлось доработать в **Vagrantfile**  директиву которая делает его совместимым с моей версией **ansible**
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

