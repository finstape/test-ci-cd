# test-ci-cd

Простой репозиторий на Python с CI/CD через GitHub Actions.

## Структура проекта

```
test-ci-cd/
├── .gitignore
├── LICENSE
├── README.md
├── pyproject.toml
├── src/
│   └── myapp/
│       ├── __init__.py
│       └── app.py
├── tests/
│   ├── __init__.py
│   └── test_app.py
├── Dockerfile
├── public/
│   └── index.html
├── src/
│   ├── myapp/
│   │   ├── __init__.py
│   │   ├── app.py
│   │   └── models.py
│   └── migrations/
│       ├── env.py
│       ├── script.py.mako
│       └── versions/
│           └── 0001_initial.py
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── helm/
│   └── test-ci-cd/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
│           ├── _helpers.tpl
│           ├── deployment.yaml
│           └── service.yaml
├── tests/
│   ├── __init__.py
│   └── test_app.py
└── .github/
    ├── workflows/
    │   ├── ci.yml
    │   ├── release.yml
    │   └── pages.yml
    └── scripts/
        └── notify-telegram.sh
```

## Установка

```bash
# Клонирование репозитория
git clone https://github.com/finstape/test-ci-cd.git
cd test-ci-cd

# Создание и активация виртуального окружения
python -m venv .venv
source .venv/bin/activate   # Linux / macOS
# .venv\Scripts\activate    # Windows

# Установка зависимостей
pip install -e ".[dev]"
```

## Использование

```bash
python -m src.myapp
```

Или:

```python
from src.myapp.app import greet

print(greet("World"))
```

## Тесты

```bash
pytest
```

## Миграции базы данных

Проект использует **Alembic** для управления миграциями базы данных SQLite.

Запуск миграций:
```bash
# Установка зависимостей
pip install alembic sqlalchemy

# Применение миграций
PYTHONPATH=src alembic upgrade head

# Создание новой миграции
PYTHONPATH=src alembic revision --autogenerate -m "description"
```

## Линтер

```bash
ruff check src/ tests/
ruff format --check src/ tests/
```

## CI/CD

Каждый коммит запускает пайплайн CI:

1. **build** — сборка пакета.
2. **lint** — проверка кода через `ruff`.
3. **test** — прогон тестов через `pytest`.
4. **security** — сканирование безопасности (`bandit` + `pip-audit`).
5. **db-migrate** — применение миграций базы данных через `alembic upgrade head`.
6. **notify** — уведомление в Telegram о статусе пайплайна.

При пуше тега вида `v*` автоматически создаётся релиз на GitHub с changelog и прикреплённым артефактом сборки.

## GitHub Pages

Статический сайт проекта разворачивается на GitHub Pages при каждом пуше в ветку `main` через отдельный пайплайн `.github/workflows/pages.yml`.

Доступ по адресу: `https://finstape.github.io/test-ci-cd/`

## Kubernetes

Проект можно развернуть в кластер Kubernetes через Helm.

### Локально (kind)

```bash
# Сборка образа
docker build -t test-ci-cd:latest .

# Развертывание через Helm
helm upgrade --install test-ci-cd ./helm/test-ci-cd --namespace default --create-namespace

# Проверка статуса
kubectl rollout status deployment/test-ci-cd
```

### В CI/CD (GitHub Actions)

Workflow `.github/workflows/k8s-deploy.yml` при каждом пуше в `main`:
1. Собирает Docker-образ.
2. Поднимает локальный кластер kind.
3. Загружает образ в кластер.
4. Развертывает приложение через Helm.

## Лицензия

MIT License.
