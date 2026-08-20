from calculator import (
    add,
    subtract,
    multiply,
    divide,
    square,
)


def test_add():
    assert add(10, 5) == 15


def test_subtract():
    assert subtract(10, 5) == 5


def test_multiply():
    assert multiply(10, 5) == 50


def test_divide():
    assert divide(10, 5) == 2


def test_square():
    assert square(5) == 25

