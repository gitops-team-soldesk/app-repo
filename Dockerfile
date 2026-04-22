# =============================================
# Stage 1: Builder
# Go 애플리케이션 빌드
# =============================================
FROM golang:alpine AS builder

# 빌드에 필요한 도구 설치
RUN apk add --no-cache git ca-certificates

# 작업 디렉토리 설정
WORKDIR /app

# 의존성 파일 먼저 복사 (캐시 활용)
COPY go.mod go.sum ./
RUN go mod download

# 소스 코드 복사
COPY . .

# 바이너리 빌드 (정적 링크)
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -ldflags="-s -w" -o /podinfo ./cmd/podinfo

# =============================================
# Stage 2: Runtime
# 최소 이미지로 실행
# =============================================
FROM alpine:3.19

# 보안: 루트가 아닌 사용자 생성
RUN addgroup -g 1000 podinfo && \
    adduser -u 1000 -G podinfo -D podinfo

# CA 인증서 복사 (HTTPS 통신용)
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# [수정] UI 정적 파일 폴더 복사 추가
COPY --from=builder /app/ui /app/ui

# 빌드된 바이너리 복사
COPY --from=builder /podinfo /app/podinfo

# 실행 권한 설정
RUN chmod +x /app/podinfo

# 작업 디렉토리
WORKDIR /app

# non-root 사용자로 전환
USER podinfo

# 포트 노출
EXPOSE 9898 9999

# 헬스체크
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -qO- http://localhost:9898/healthz || exit 1

# 실행
ENTRYPOINT ["/app/podinfo"]# trigger Fri Apr 17 16:52:32     2026
# trigger Fri Apr 17 17:12:29     2026
# trigger test d6 Fri Apr 17 17:12:47     2026
# trivy test Fri Apr 17 17:20:40     2026
# trigger D6 Tue Apr 21 19:35:57     2026
# trigger D6 Tue Apr 21 19:39:03     2026 #2
# test #1 Wed Apr 22 14:25:24     2026
