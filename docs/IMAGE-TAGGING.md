# 이미지 태그 규칙

## 형식
`v{MAJOR}.{MINOR}.{PATCH}-{YYMMDD}-{SHORT_SHA}`

## 예시
- `v1.0.0-240412-abc1234`
- `v1.0.1-240413-def5678`

## 구성 요소
- `v1.0.0`: Semantic Version
- `240412`: 빌드 날짜 (YYMMDD)
- `abc1234`: Git commit hash (7자리)

## latest 태그
- 항상 최신 main 브랜치 빌드
- **프로덕션에서는 사용 금지!**

## 환경별 정책
| 환경 | 태그 정책 | 자동화 |
|------|----------|--------|
| dev | 모든 main 커밋 | 자동 |
| prod | 태그 릴리스만 | 수동 승인 |