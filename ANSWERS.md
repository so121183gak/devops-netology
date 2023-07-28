### Ответы на вопрос к заданию "Инструменты Git"

#### Команда git show aefea
- Полный хеш коммита **aefea**: ```aefead2207ef7e2aa5dc81a34aedf0cad4c32545```<br>
- Коментарий коммита **aefea**: ```Update CHANGELOG.md```<br>

#### Команда git show 85024d3
- На коммит ```85024d3``` ссылается следующий тег: **tag: v0.12.23**<br>

#### Команда git show --pretty=%P b8d720
- У коммита ```b8d720``` два родителя их хеши следующие: ```56cd7859e05c36c06b56d013b55a252d0bb7e158```, ```9ea88f22fc6269854151c571162c5bcf958bee2b```<br>

#### Команда git log --pretty=format:'%h %s' v0.12.23..v0.12.24
- Между тегами v0.12.23 и v0.12.24 идут следующие коммиты:<br>
```33ff1c03bb v0.12.24```<br>
```b14b74c493 [Website] vmc provider links```<br>
```3f235065b9 Update CHANGELOG.md```<br>
```6ae64e247b registry: Fix panic when server is unreachable```<br>
```5c619ca1ba website: Remove links to the getting started guide's old location```<br>
```06275647e2 Update CHANGELOG.md```<br>
```d5f9411f51 command: Fix bug when using terraform login on Windows```<br>
```4b6d06cc5d Update CHANGELOG.md```<br>
```dd01a35078 Update CHANGELOG.md```<br>
```225466bc3e Cleanup after v0.12.23 release```<br>

#### Команда git log --grep='providerSource' 
- К сожалению в данном репазитории я не нашел функции **func providerSource** однако я нашел функцию **TestInit_providerSource**<br>
которая находится в коммите ```c81eebe0ac8c30358933009b7e133fae90cd6106```<br> 

#### Команда git show --name-only c81eebe0ac8c30358933009b7e133fae90cd6106
- Коммит ```c81eebe0ac8c30358933009b7e133fae90cd6106``` указывает на файл **init_test.go**<br> 

#### Команда find . -name "init_test.go" -exec grep -H "providerSource" {} \;
- Находим нужный файл **init_test.go**<br>

#### Команда cat ./internal/command/init_test.go |grep TestInit_providerSource -A "5"
- Смотри код в этом файле **init_test.go**  есть следующий код: ```func TestInit_providerSource(t *testing.T)```<br>

#### Команда git log -S globalPluginDirs --oneline --decorate
- Функция globalPluginDirs была изменена в следующих коммитах:<br>
```65c4ba7363 Remove terraform binary```<br>
```125eb51dc4 Remove accidentally-committed binary```<br>
```22c121df86 Bump compatibility version to 1.3.0 for terraform core release (#30988)```<br>
```7c7e5d8f0a Don't show data while input if sensitive```<br>
```35a058fb3d main: configure credentials from the CLI config file```<br>
```c0b1761096 prevent log output during init```<br>
```8364383c35 Push plugin discovery down into command package```<br>

#### Команда git log --grep='synchronizedWriters'
- К сожалению в данном репазитории я не нашел коммитов в которых есть упоминание о функции **synchronizedWriters**



