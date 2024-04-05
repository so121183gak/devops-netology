#Финансове планирование
salary_month = int(input('Введите заработную плату уходит на ипотеку: '))
life_yer = int(input('Введите, какой процент(%) уходит на жизнь: '))
mortgage_yer_sum = int(salary_month * 12 * mortgage_yer/100)
life_yer_sum = int(salary_month * 12 * life_yer/100)
savings_yer_sum = salary_month * 12 - mortgage_yer_sum - life_yer_sum

print(f'Вывод:\n Ипотека в год:{mortgage_yer_sum}\n Накопления в год:{savings_yer_sum}\n')