Квадрат и прямоугольник.
square = int(input('Введите длину стороны квадрат '))
square_perimeter = square * 4
square_area = square * square
print(f'Вывод:\n Периметр:{square_perimeter}\n Площадь:{square_area}\n')

rectangle_length = int(input('Введите длину прямоугольника '))
rectangle_width = int(input('Введите ширину прямоугольника '))
rectangle_perimeter = rectangle_length * 2 + rectangle_width * 2
rectangle_area = rectangle_length * rectangle_width
print(f'Вывод:\n Периметр:{rectangle_perimeter}\n Площадь:{rectangle_area}\n')

