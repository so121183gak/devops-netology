# Квадрат и прямоугольник.
# square = int(input('Введите длину стороны квадрат '))
# square_perimeter = square * 4
# square_area = square * square
# print(f'Вывод:\n Периметр:{square_perimeter}\n Площадь:{square_area}\n')

# rectangle_length = int(input('Введите длину прямоугольника '))
# rectangle_width = int(input('Введите ширину прямоугольника '))
# rectangle_perimeter = rectangle_length * 2 + rectangle_width * 2
# rectangle_area = rectangle_length * rectangle_width
# print(f'Вывод:\n Периметр:{rectangle_perimeter}\n Площадь:{rectangle_area}\n')

salary_month = int(input('Введите заработную плату в месяц: '))
mortgage_yer = int(input('Введите, какой процент(%) уходит на ипотеку: '))
life_yer = int(input('Введите, какой процент(%) уходит на жизнь: '))
mortgage_yer_sum = int(salary_month * 12 * mortgage_yer/100)
life_yer_sum = int(salary_month * 12 * life_yer/100)
savings_yer_sum = salary_month * 12 - mortgage_yer_sum - life_yer_sum

print(f'Вывод:\n Ипотека в год:{mortgage_yer_sum}\n Накопления в год:{savings_yer_sum}\n')