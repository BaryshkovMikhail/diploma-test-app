# ============================================================
# Dockerfile для тестового приложения диплома
# ============================================================

# 📦 Базовый образ: минимальный nginx
FROM nginx:1.25-alpine

# 🏷️ Метки для реестра
LABEL maintainer="m.baryshkov@mail.ru"
LABEL org.opencontainers.image.title="Diploma Test App"
LABEL org.opencontainers.image.description="Test nginx application for DevOps diploma project"
LABEL org.opencontainers.image.source="https://github.com/BaryshkovMikhail/diploma-test-app"
LABEL org.opencontainers.image.licenses="MIT"

# 🔧 Копируем конфигурацию nginx
COPY nginx.conf /etc/nginx/nginx.conf

# 📄 Копируем статическую страницу
COPY index.html /usr/share/nginx/html/index.html

# 🔓 Открываем порт
EXPOSE 80

# 🏃 Запуск nginx в форграунде (требуется для Docker)
STOPSIGNAL SIGTERM

# Healthcheck для Kubernetes
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/health || exit 1

# Запускаем nginx
CMD ["nginx", "-g", "daemon off;"]
