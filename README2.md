# Введение в виртуализацию

### 1. Задача
- **Полная аппаратная вируализация** по сути исключает уровень абстракции операционной системы, которая достигается за счет добавление специальных инструкций в центральные процессоры, в таком случае операционной системе необходим нулевой уровень приоритета для доступа к аппаратным ресурсам физического сервера, такой подход сразу же сказался на скорости. При таком раскладе функции хотсовой ОС на себя берет **гипервизор**.
- **Паравиртуализация** нуждается в уровне абстракции операционной системы которая позволяет получить доступы к аппаратным ресурсам сервера, так же **гипервизор** такого типа модифицирует ядро гостевой ОС для доступа к аппаратным ресурсам физического сервера.
- **Виртуализация уровня ОС** может работать с изолированными ОС на одном хосте но не может запускать ОС  ядра которых отличаются от хотсовой ОС, в данном случае роль **гипервизора** отводится ядру хостовой ОС (такой подход еще называют **контейнеризацией**). Такой подход позволяет контейнерам монтировать устройства хостовой машины

### 2. Задача
- **высоконагруженная база данных, чувствительная к отказу** для таких условий я бы выбрал **виртуалтзацию на уровне ОС**. Сделал бы я это потому что нам необходима гибкое выделение ресурсов и при использовании кластеризации Kubernetes мы добьемся отказоустойчивости системы.
- **различные web-приложения** для таких условий я бы опять выбрал бы **виртуалтзацию на уровне ОС**. Сделал бы я это потому что нам необходим гибкий инструментарий для управления микросервисной архитектурой, в зависимости от масштабов проекта можно было бы организовать за счет использования **Docker compose** или **Docker swarm**
- **Windows-системы для использования бухгалтерским отделом** для таких условий я бы выбрал **паравиртуализацию**. Сделал бы я это потому что было бы удобно разворачивать Windows системы используя **гипервизор** и далее поддерживать эту систему с точки зрения резервного копирования и изминения конфигураций гостевых ОС, ну и такое решение позволило бы сэкономить денег компании, так как нет необходимости переплачивать за **аппаратную виртуализацию** данное решение оптимально для этих условий.
- **системы, выполняющие высокопроизводительные расчёты на GPU** для таких условий я бы выбрал **физические сервера**. Сделал бы я это потому что, работа с видеокартами все же требует прямого доступа к железу, для обеспечения хорошей скорости работы, например нейронной сети, лучше делать такое напрямую.

### 3. Задача
1. Можно использовать **аппаратную виртуализацию**  например решения на ESXI и CITRIX, в этих системах легко можно поднять любые гостевые ОС, у них довольно хорошая скорость к ресурсам физического сервера что будет плюсом так как необходимо 100 виртуальных машин. В коммерческих варианты этих **гипервизоров** есть репликация, балансировка нагрузки и автоматическое резервное копирование.

2. Можно использовать **паравиртуализацию** например решения на Proxmox, у данного гипервизора есть модифицированные драйвера которые помогут добиться высокой производительности гостевой ОС, так же если сервер поддерживает например Intel Vt-d, то это тоже повлияет на скорость работы гостевой ОС.

3. Можно использовать **паравиртуализацию** например решение на Microsoft Hyper-V, у данного гипервизора отличная совместимость с экосистемой Microsoft.

4. Можно использовать **виртуалтзацию на уровне ОС** например решение на Docker, у данного подхода много преимуществ легковестность, не нужен **гипервизор** а значит и большие системные ресурсы, сервер может быть средненьким, в контейнерах отлично можно развернуть самые разные дистрибутивы начиная с ubuntu и заканчивая леuковесными типа alpine, если речь не стоит о тестирование на поределенноых ядрах это лучший вариант для такого случая, так как ядро контейнеров будет заимствоваться из хостовой ОС.

### 4. Задача
Любая более менее сложная система лучше поддается описанию, контролю и формализации когда мы ее стандартизируем, исходя из этого я бы не делал гетерогенную среду, если только на это не было бы веских причин. Такой подход затрудняет обслуживание, резервное копирование и усовершенствование системы в целом, что ведет за собой, ошибки, простои и прочие накладные расходы.<br>
Пример: 
Имеем систему на KVM для сборки приложений, пока компания маленькая достаточно ее, тут вдруг, компания начинает рост, покупается новый сервер на базе ESXI где тоже будут сервера сборки приложений, но руководство просит оставить сервер KVM и использовать его дальше. Вдруг случается внештатная ситуация мы теряем сервер сборки на ESXI с последней подготовленной средой для сборки приложения. Руководство просит организовать автоматическое резервное копирование всех сборочных серверов на KVM и ESXI. На ESXI этот функционал есть из коробки на KVM придется сооброжать как это сделать, по итогу получаем неконсистентность нашей среды, которая выливается в дополниельную нагрузку как на разработку так и на контроль обоих систем.


