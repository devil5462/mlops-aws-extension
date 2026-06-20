# MLOps Platform - AWS Cloud Extension
## LG MLDL DAP의 AWS 클라우드 확장 경험

> **프로젝트**: LG MLDL DAP 기반 AWS 클라우드 환경 확장  
> **기간**: 동시 진행 (2023년 6월 ~ 2024년 12월)  
> **규모**: 다중 리전 배포, 탄성 스케일링  
> **주요 성과**: 비용 최적화 40%, 글로벌 확장성 확보

---

## 🌍 프로젝트 개요

**LG MLDL DAP 플랫폼을 AWS 클라우드 환경에서 완전히 재구현**한 경험입니다.

온프레미스 기반의 메인 플랫폼을 AWS로 마이그레이션하면서:
- 완전 관리형 서비스 활용 (AWS 책임 전가)
- 탄성 스케일링으로 비용 최적화
- 다중 리전 배포로 글로벌 확장성 확보
- DevOps 운영 간소화

---

## 📊 AWS vs 온프레미스 비교

| 항목 | 온프레미스 | AWS 클라우드 |
|------|----------|-----------|
| **관리 책임** | 전적으로 담당 | AWS가 기반 담당 |
| **인프라 운영** | 물리 서버 관리 필수 | 완전 자동화 |
| **스케일링** | 용량 계획 필요 | 자동 탄성 스케일링 |
| **비용 모델** | 고정 비용 | 변동 비용 (사용량) |
| **글로벌 확장** | 복잡한 구축 | AWS 리전 활용 간단 |
| **운영 효율** | 수동 작업 많음 | 자동화 극대화 |
| **초기 구축** | 장기간 (3-6개월) | 빠름 (1-2개월) |

---

## 🏗️ AWS 기반 아키텍처

```
┌─────────────────────────────────────────────────────┐
│         AWS 관리형 서비스 (AWS 책임)                 │
├─────────────────────────────────────────────────────┤
│ EKS | RDS | S3 | ECR | SageMaker | CloudWatch       │
└─────────────────────────────────────────────────────┘
                         ↑
┌─────────────────────────────────────────────────────┐
│      사용자 애플리케이션 계층 (사용자 책임)           │
├─────────────────────────────────────────────────────┤
│                                                       │
│  [1] 데이터 계층                                     │
│  ├─ Kafka MSK (관리형)                              │
│  ├─ S3 Data Lake                                    │
│  └─ Spark EMR (탄성)                                │
│                                                       │
│  [2] 모델 계층                                       │
│  ├─ SageMaker Training (자동 스케일링)              │
│  ├─ SageMaker Processing (Spark 자동 관리)         │
│  └─ SageMaker Model Registry                       │
│                                                       │
│  [3] 배포 계층                                       │
│  ├─ EKS Cluster (3개 AZ)                            │
│  ├─ ECR (프라이빗 레지스트리)                        │
│  ├─ SageMaker Endpoints (모델 서빙)                 │
│  └─ ALB (로드 밸런싱)                               │
│                                                       │
│  [4] 모니터링 계층                                   │
│  ├─ CloudWatch (AWS 통합)                           │
│  ├─ X-Ray (분산 추적)                               │
│  └─ CloudWatch Logs (중앙 로깅)                     │
│                                                       │
└─────────────────────────────────────────────────────┘
```

---

## 🔧 핵심 기술 스택 (AWS)

### 데이터 처리
- **Kafka MSK**: 관리형 Kafka (온프레미스 Kafka 동일)
- **S3**: 객체 저장소 (데이터 레이크)
- **EMR Spark**: 탄성 스케일링 (자동 노드 추가/제거)

### 모델 개발
- **SageMaker Training**: 자동 스케일링, GPU 최적화
- **SageMaker Processing**: Spark 자동 관리
- **SageMaker Model Registry**: 완전 관리형

### 배포 및 서빙
- **EKS**: Kubernetes (AWS 관리)
- **ECR**: Docker 레지스트리 (자동 스캔)
- **SageMaker Endpoints**: 자동 스케일링, A/B 테스트
- **ALB**: 애플리케이션 로드 밸런서

### 모니터링
- **CloudWatch**: 통합 모니터링
- **CloudWatch Logs**: 중앙 로깅
- **X-Ray**: 분산 추적
- **SNS/SQS**: 알림 및 메시지 큐

---

## 💰 비용 최적화

### 1. Compute 비용 절감

**EC2 Spot Instances** (30% 비용 절감)
```
온디맨드: $0.50/시간
Spot: $0.15/시간 (70% 할인)

사용처: 개발/테스트, 학습 작업
제약: 언제든 종료 가능 → 프로덕션에는 온디맨드
```

**Reserved Instances** (40% 비용 절감)
```
1년 선불: 40% 할인
3년 선불: 60% 할인

사용처: 프로덕션 핵심 서버
기준: 항상 켜있는 서버
```

**Auto Scaling** (동적 비용 제어)
```
피크: 8개 인스턴스
오프피크: 2개 인스턴스

효과: 불필요한 리소스 자동 제거
```

### 2. Storage 비용 절감

**S3 Storage Class** (50% 비용 절감)
```
Standard: $0.023/GB
Intelligent-Tiering: $0.0125/GB (자동 이동)
Glacier: $0.004/GB (아카이브)

정책: 최근 데이터 Standard, 오래된 데이터 자동 이동
```

### 3. Data Transfer 비용 절감

**CloudFront CDN** (비용 절감 + 성능 향상)
```
리전 간 전송: 비용 증가
CloudFront 사용: 비용 절감 + 캐싱
```

### 총 비용 절감

```
기존 온프레미스: 월 $50K
AWS 최적화: 월 $30K

절감액: 월 $20K (40% 감소)
연간: $240K 절감
```

---

## 🌐 글로벌 확장성

### Multi-Region 배포

```
Primary Region (서울: ap-northeast-2)
├─ EKS Cluster
├─ RDS (Primary)
└─ S3 (Primary)
    ↓ (Cross-region replication)
Secondary Region (도쿄: ap-northeast-1)
├─ EKS Cluster (대기)
├─ RDS (Read Replica)
└─ S3 (복제)
```

**효과**:
- 재해 복구: 자동 페일오버
- 저지연: 사용자 가까운 리전에서 서빙
- 규정 준수: 데이터 거주 요구사항 충족

---

## 📊 성과 지표

### 개발 생산성
| 메트릭 | 기존 | AWS | 개선 |
|--------|------|-----|------|
| 배포 시간 | 2일 | 30분 | 96% ↓ |
| 스케일링 | 수동 | 자동 | 100% 자동화 |
| 인프라 구축 | 3개월 | 1개월 | 67% ↓ |

### 비용 효율
```
월 비용 절감: $20K
연간 절감: $240K
ROI: 2개월 이내
```

### 운영 효율
```
수동 작업: 90% 제거
자동화 비율: 95%
장애 복구: 자동 (1분)
```

---

## 🚀 AWS의 장점 (온프레미스 대비)

### 1. 탄성 스케일링
```
사용량에 따라 자동으로:
├─ 인스턴스 추가/제거
├─ 데이터베이스 성능 조정
└─ 스토리지 자동 확장

결과: 과잉 프로비저닝 제거 → 비용 절감
```

### 2. 관리 책임 감소
```
온프레미스 책임: 서버, 네트워크, 보안, 백업, 패칭
AWS 책임: AWS가 대부분 담당
결과: 운영팀 규모 50% 축소 가능
```

### 3. 글로벌 인프라
```
온프레미스: 데이터센터 1곳 (서울)
AWS: 31개 리전, 99개 가용 영역

결과: 글로벌 확장 용이, 저지연 서비스 가능
```

### 4. 통합 서비스
```
AWS 제공:
├─ 모니터링 (CloudWatch)
├─ 로깅 (CloudWatch Logs)
├─ 분석 (Athena, Redshift)
└─ 머신러닝 (SageMaker)

결과: 각 도구 개별 구축 불필요 → 시간/비용 절감
```

---

## 📁 저장소 구조

```
mlops-aws-extension/
├── README.md (이 파일)
├── architecture/
│   ├── aws-architecture.md
│   ├── cost-optimization.md
│   └── multi-region-setup.md
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── eks.tf
│   ├── rds.tf
│   └── s3.tf
│
├── aws-services/
│   ├── sagemaker/
│   │   ├── training-job.py
│   │   └── model-registry.py
│   ├── emr/
│   │   └── spark-job.yaml
│   └── msk/
│       └── kafka-config.yaml
│
├── eks-setup/
│   ├── cluster-config.yaml
│   ├── nodegroup.yaml
│   └── alb-controller.yaml
│
└── cost-optimization/
    ├── spot-instances.md
    ├── reserved-instances.md
    └── monitoring-spend.yaml
```

---

## 🎓 AWS 마이그레이션 배운 점

### 1. 클라우드의 가치는 자동화
- 수동 운영은 클라우드 가치를 못 씀
- 완전 자동화 = 비용 절감 + 안정성 향상

### 2. 비용은 아키텍처 결정
- 인스턴스 크기보다 "사용 패턴"이 중요
- Reserved + Spot + On-demand 혼합 전략

### 3. AWS 서비스는 도구
- 무조건 사용하는 게 아니라 필요할 때만
- 온프레미스와 AWS를 적절히 혼합

### 4. 마이그레이션은 점진적
- 한 번에 다 옮기려 하면 실패
- 프로젝트별 단계적 마이그레이션

---

## 📞 문의

GitHub Issues를 통해 질문해주세요!

---

**마지막 업데이트**: 2024년 6월  
**버전**: 1.0.0  
**관련 프로젝트**: mlops-lgcns-mldl-platform (메인)
