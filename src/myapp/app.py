"""Основной модуль приложения."""


def greet(name: str) -> str:
    """Вернуть приветствие для указанного имени."""
    return f"Hello, {name}!"


def main() -> None:
    """Точка входа в приложение."""
    print(greet("World"))


if __name__ == "__main__":
    main()
