"""Main application module."""


def greet(name: str) -> str:
    """Return greeting for the specified name."""
    return f"Hello, {name}!"


def main() -> None:
    """Application entry point."""
    print(greet("World"))


if __name__ == "__main__":
    main()
