"""Tests for the app module."""

from src.myapp.app import greet


def test_greet() -> None:
    """Test greet function with a normal name."""
    assert greet("World") == "Hello, World!"


def test_greet_empty_name() -> None:
    """Test greet function with an empty name."""
    assert greet("") == "Hello, !"
