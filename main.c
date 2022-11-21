#include <stdio.h>

double foo(double a, double b, double x) {
    return a + b * x * x * x;
}


// из графика функции видим, что самая большая погрешность будет у первого или последнего прямоугольника
// принимаем таковой погрешность каждого прямоугольника
// подбираем d

// в вырожденном случае b = 0 погрешность появляется лишь из-за последнего неучтённого прямоугольника
// исходя из нее вычисляем d

// P. S. в первом случае ожидаем, что погрешность неучтённого прямоугольника будет малозначимой
// по сравнению с погрешностью из-за приближения прямоугольниками
double getD(double a, double b, double right, double left) {
    if (b < 0) {
        b = -b;
    }
    if (b == 0) {
        return (right - left) / (1 / 0.00005);
    }
    
    double right_res = foo(a, b, right);
    double len = right - left;
    double d = 0.01;
    while ((right_res - foo(a, b, right - d)) * len > 0.0001) {
        d /= 2;
    }
    double left_res = foo(a, b, left);
    while ((foo(a, b, left + d) - left_res) * len > 0.0001) {
        d /= 2;
    }
    return d;
}


// под методом недостатков понимается метод левых прямоугольников
int main()
{
    double a, b;
    scanf("%lf %lf", &a, &b);
    double left, right;
    scanf("%lf %lf", &left, &right);
    double result = 0.0;
    int minus = 1;
    if (left == right) {
        printf("0\n");
        return 0;
    }
    if (left > right) {
        double temp = right;
        right = left;
        left = temp;
        minus = -1;
    }
    double d = getD(a, b, right, left);
    for (; left < right; left += d) {
        result += foo(a, b, left) * d;
    }
    
    result *= minus;
    printf("%lf\n", result);
    return 0;
}
