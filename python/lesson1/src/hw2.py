#Финансове планирование
salary_month = int(input('Введите заработную плату в месяц: '))
mortgage_year = int(input('Введите, какой процент(%) уходит на ипотеку: '))
life_year = int(input('Введите, какой процент(%) уходит на жизнь: '))
mortgage_year_sum = int(salary_month * 12 * mortgage_year/100)
life_year_sum = int(salary_month * 12 * life_year/100)
savings_year_sum = salary_month * 12 - mortgage_year_sum - life_year_sum

print(f'Вывод:\n Ипотека в год:{mortgage_year_sum}\n Накопления в год:{savings_year_sum}\n')