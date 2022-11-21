#include <stdio.h>

double foo(double a, double b, double x) {
    return a + b * x;
}


// заметим, что потери при подсчётах: ( b * d * (right - left) ) / 2 | d - ширина прямоугольников
// т. к. хотим отклонение не более 0.0001 составим неравенство на d
// d < 0.00005 / (|b| * (right - left))
// d := 0.000025 / (|b| * (right - left))
double getD(double b, double right, double left) {
    if (b < 0) {
        b = -b;
    }
    return 0.000025 / (b * (right - left));
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
    double d = getD(b, right, left);
    for (; left < right; left += d) {
        result += foo(a, b, left) * d;
    }
    
    result *= minus;
    printf("%lf\n", result);
    return 0;
}
