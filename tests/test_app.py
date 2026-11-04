"""Тесты для модуля app."""

from src.myapp.app import greet


def test_greet() -> None:
    """Проверка функции greet с обычным именем."""
    assert greet("World") == "Hello, World!"


def test_greet_empty_name() -> None:
    """Проверка функции greet с пустым именем."""
    assert greet("") == "Hello, !"
