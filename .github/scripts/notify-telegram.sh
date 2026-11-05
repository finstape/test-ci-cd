#!/usr/bin/env bash
set -euo pipefail

STATUS="${1}"
case "${STATUS}" in
  success)    EMOJI="✅" ;;
  failure)    EMOJI="❌" ;;
  cancelled)  EMOJI="⏹️" ;;
  *)          EMOJI="⚠️" ;;
esac

TEXT="${EMOJI} CI Pipeline: ${STATUS}

Project: test-ci-cd
Repository: ${GITHUB_REPOSITORY}
Commit: ${GITHUB_SHA}
Branch: ${GITHUB_REF_NAME}
Triggered by: ${GITHUB_ACTOR}
Workflow run: ${GITHUB_RUN_ID}

Jobs:
• build: ${BUILD_RESULT}
• lint: ${LINT_RESULT}
• test: ${TEST_RESULT}
• security: ${SECURITY_RESULT}
• db-migrate: ${DB_MIGRATE_RESULT}

View run: ${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"

curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -d chat_id="${TELEGRAM_CHAT_ID}" \
  -d text="${TEXT}" \
  -d parse_mode="Markdown" > /dev/null || echo "Failed to send Telegram notification"
