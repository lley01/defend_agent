# 1q2w3e4r! 새 환경 재현과 릴리스 기록

학생이 작성한 22단계 문서입니다. 같은 커밋을 새 빈 폴더에서 받아 실행한 결과와 13~21단계 기능별 확인 상태, 데이터 보존 계획, 버전·지원 범위를 정리합니다.
실행 방법과 구성도는 [STUDENT_RUNBOOK.md](STUDENT_RUNBOOK.md)를 따릅니다.

## 0. 근거의 종류

이 문서의 결과는 아래 네 종류로 나눠 적습니다. 서로 다른 종류의 결과를 합쳐 "전체 성공"으로 쓰지 않습니다.

| 표기 | 뜻 |
|---|---|
| **원문 확인** | 커밋된 코드·문서를 읽고 대조한 것. 실행 결과가 아님 |
| **모의 점검** | 학생 함수에 모의 입력을 넣어 화면 글자·속성을 확인한 것(jsdom). 실제 서버·계정 연결이 아님 |
| **실행 검증(연결 없음)** | 새 폴더에 받은 커밋으로 실제 서버를 켜고 HTTP 응답을 확인한 것. 외부 시스템 연결 없이 `disconnected` 상태 |
| **학생 진술** | 학생이 자기 PC에서 직접 실행하고 적은 관찰 결과. 서버가 대신 실행한 것이 아님 |

ALEPH 서버 AI의 원문 검토 통과는 실행 성공의 증명이 아닙니다. 22단계 통과는 원문 검토 기준의 수료이며, 실제 운영 인증이나 v1.0 인증이 아닙니다.

## 1. 버전

| 항목 | 값 |
|---|---|
| 학생 버전 표기 | **0.2.14-student.1 (검증 중)** — 미완료 항목이 남아 v1.0으로 표시하지 않음 |
| 시작 틀 버전 | `alekov-client-starter` 0.2.14 (`package.json`), 폴더 이름 `alekov-starter-0.2.11` |
| 저장소 | `https://github.com/lley01/defent_agent` (비공개 저장소일 수 있음) |
| 브랜치 | `main` |
| 재현 대상 커밋 | `2d024ccc31fa4db7a34e424d4b013babc9c847bc` (21단계까지의 코드·문서) |
| 이 문서를 추가한 커밋 | 재현 대상 커밋 다음 커밋. **문서 파일만 바뀌고 코드·설정·실행 진입점은 재현 대상 커밋과 같음** |

이 문서를 추가한 커밋과 재현 대상 커밋의 차이는 아래 명령으로 확인합니다. `docs/STUDENT_RELEASE_RECORD.md`와 학생 README·실행 설명서만 나오면 코드가 같다는 뜻입니다.

```powershell
git diff --stat 2d024ccc31fa4db7a34e424d4b013babc9c847bc HEAD
```

### 커밋 기록 (한국 시각)

| 커밋 | 시각 | 내용 |
|---|---|---|
| `a963344` | 2026-10-23 10:12 | first commit |
| `79ab4eb` | 2026-10-23 10:16 | 커밋 메시지 `-` (시작 틀 `on-client` 파일 추가) |
| `ad0a042` | 2026-10-23 10:26 | 13단계 `renderIdentity` |
| `5e8fffc` | 2026-10-23 10:42 | 14단계 `renderDecision` |
| `8af55d0` | 2026-10-23 10:49 | 15단계 `renderEvents` |
| `ff0c54d` | 2026-10-23 11:02 | 16단계 `renderStatus`, 15단계 상세의 미지원 조치 안내 |
| `730dd8b` | 2026-10-23 11:29 | 17단계 `renderAiConnection`, `renderExplanation` 기초 |
| `9df87f0` | 2026-10-27 14:58 | 18단계 `renderExplanation` 완성 |
| `c2ccaee` | 2026-10-27 15:13 | 19단계 `renderAction` |
| `2d41afc` | 2026-10-27 16:35 | 20단계 `renderVulnerabilities` |
| `2d024cc` | 2026-10-27 16:45 | 21단계 학생 README·실행 설명서·구성도 |

## 2. 새 환경 재현 절차

원래 작업 폴더는 그대로 두고, 새 빈 폴더에서 같은 커밋을 받습니다. 원래 폴더의 계정 연결 설정·자격 보관소·`.env`는 복사하지 않습니다.

```powershell
# 1) 프로젝트 밖에 새 빈 폴더를 만들고 그 안에서 PowerShell을 엽니다.
git clone https://github.com/lley01/defent_agent.git .
git checkout 2d024ccc31fa4db7a34e424d4b013babc9c847bc
git rev-parse HEAD            # 2d024ccc31fa4db7a34e424d4b013babc9c847bc 인지 확인
node -v                       # v22~v24 (기준 v24.19.0)

# 2) 앱 폴더로 이동해 문법 확인 후 실행
cd .\alekov-starter-0.2.11\on-client
npm run check
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\start-alekov.ps1
# 3) 브라우저로 http://127.0.0.1:5189/ 확인 → 실행 창에서 Ctrl+C로 종료 → 같은 명령으로 재실행
```

- 비공개 저장소라면 `git clone`에 GitHub 로그인이 필요할 수 있습니다. 비밀번호·토큰을 문서나 명령 기록에 남기지 않습니다.
- 외부 npm 의존성이 없어 `npm install` 단계는 없습니다(`package.json`에 `dependencies` 없음, `package-lock.json` 없음).
- 새 폴더는 경로가 달라 계정 연결 보관소도 새로 만들어집니다(6장). 계정 연결은 새로 진행해야 합니다.

## 3. 재현 결과

### 3-1. 실행 검증(연결 없음) — Claude 작업 환경

학생 PC가 아니라 수업용 AI(Claude)의 클라우드 작업 환경에서 실행한 결과입니다. 지원 환경(Windows PowerShell)이 아니므로 실행 도구 `start-alekov.ps1`은 실행하지 않았고, 같은 서버 진입점 `node src/server.mjs`(= `npm start`)로 켰습니다.

| 항목 | 값 |
|---|---|
| 확인 시각 | 2026-10-27 16:49 KST (07:49:50Z) |
| 환경 | Linux, Node.js v22.22.0 (지원 범위 22~24 안, 기준 버전 24.19.0은 아님) |
| 폴더 | 새 빈 폴더에 `git clone` 후 `git checkout 2d024cc…` (`git rev-parse HEAD` 일치, 변경 파일 0개) |

| 절차 | 관찰 결과 |
|---|---|
| 문법 확인 `node --check student/extension.mjs` | 오류 없음 |
| 서버 실행 | 실행 창에 `케셰브 연결 확인: http://127.0.0.1:5189` 출력 |
| `GET /` | 200, `text/html` — 3개 메뉴(보호 현황·업무 앱·보안 기록)와 학생 칸 8개가 있는 화면 원문 |
| `GET /student/extension.mjs` | 서버가 보낸 파일과 클론한 파일의 SHA-256이 같음 |
| `GET /api/me`·`/api/apps`·`/api/events`·`/api/devices`·`/api/sessions` | `ok:false`, `ENGINE_NOT_CONNECTED`, `meta.mode: disconnected` (SDP 설정 없이 실행한 정상적인 연결 없음 상태) |
| `GET /api/diagnostics` | `component: on-client`, `engine.mode: disconnected`, `engine.code: ENGINE_NOT_CONNECTED`, 비밀값 없음 |
| `GET /api/vulnerabilities` | `status: not_configured`, `code: PROJECT_NOT_CONFIGURED`, `packages: []` |
| 종료 → 재실행 → 종료 | 응답 없음 → 200 → 응답 없음 |
| 원래 작업 폴더 | 커밋 `2d024cc…` 그대로, 변경 파일 0개 |

브라우저 화면 렌더링·키보드 조작은 이 환경에서 확인하지 않았습니다(미확인).

### 3-2. 학생 PC 재현 — 학생 진술

| 항목 | 관찰 결과 |
|---|---|
| 확인 시각 | 미확인 |
| Windows 버전 / `node -v` | 미확인 |
| 새 폴더에서 `git rev-parse HEAD` | 미확인 |
| `npm run check` | 미확인 |
| 실행 도구 정상 시작 두 줄 | 미확인 |
| 브라우저 화면·3개 메뉴(마우스·Tab·Enter) | 미확인 |
| Ctrl+C 종료 → 재실행 | 미확인 |
| 원래 작업 폴더 보존 | 미확인 |

학생이 직접 실행한 뒤 이 표를 채웁니다. 채우기 전에는 학생 PC 재현을 완료로 보지 않습니다.

## 4. 13~21단계 기능별 확인 상태

모의 점검은 2026-10-27 16:49 KST에 3-1의 새 폴더 클론(커밋 `2d024cc`)의 `student/extension.mjs`로 다시 실행한 결과입니다. 이후 단계에서 의도적으로 바뀐 이전 대기 문구·기초 동작을 확인하던 항목은 제외하고 셉니다(13: 1개, 14: 1개, 15: 1개, 17: 4개 — 18단계에서 `renderExplanation`을 완성하며 바뀜).

| 단계 | 기능(함수) | 모의 점검 | 실행 검증(연결 없음) | 실제 시스템 연결 | 미확인 원인 |
|---|---|---|---|---|---|
| 13 | 로그인 사용자·기기·세션 (`renderIdentity`) | 12/12 통과 | `/api/me` 등이 `ENGINE_NOT_CONNECTED` → 학생 칸은 "연결 실패: …" 표시 대상 | 미확인 | SDP 개인 설정을 안내받지 않음 |
| 14 | 업무 앱 접근 판정 (`renderDecision`) | 13/13 통과 | `/api/apps` 연결 없음 → 앱 목록 없음 | 미확인 | SDP 연결 없음 |
| 15 | 접속 기록·XDR 경보 (`renderEvents`) | 28/28 통과 | `/api/events` 연결 없음 | 미확인 | SDP 연결 없음 |
| 16 | 알림·빈 상태·오류·도움정보 (`renderStatus`) | 25/25 통과 | `/api/diagnostics` 응답 확인(6개 값 필드 존재) | 해당 없음(로컬) | 화면의 「도움정보 복사」 실제 클립보드 동작 미확인 |
| 17 | AI 연결 점검 (`renderAiConnection`) | 17/17 통과 | 미실행 | 기다림(UNV) | 계정 연결 결과 확인 불가, 앱 권한 준비 전 |
| 18 | 근거 연결 AI 설명 (`renderExplanation`) | 27/27 통과 | 미실행 | 기다림(UNV) | 17단계 권한 준비 전. 유료 요청을 시험으로 보내지 않음 |
| 19 | 조치 요청 상태 (`renderAction`) | 24/24 통과 | 미실행 | 기다림(UNV) | `supportedActions`가 비어 있고 실제 집행 연결이 준비되지 않음 |
| 20 | 패키지 버전·OSV (`renderVulnerabilities`) | 24/24 통과 | `/api/vulnerabilities` = `not_configured` | 미확인 | `ON_PROJECT_DIRECTORY`·허용 목록 미설정(운영자 준비) |
| 21 | 실행 설명서·구성도 | 해당 없음 | 설명서의 실행 명령·시작 문구를 3-1에서 대조 | 해당 없음 | 학생 PC에서 설명서대로 실행한 결과 미확인(3-2) |

모의 점검 통과는 실제 시스템 연결 성공이 아닙니다. 예제(demo) 모드 결과는 이 표에 넣지 않았습니다.

## 5. 이동 가능한 구성

| 항목 | 상태(원문 확인) |
|---|---|
| 필요한 파일 | 저장소 전체. `on-client/` 안에 서버·화면·학생 코드·실행 도구가 모두 있음 |
| 설치 | Node.js만 필요. 외부 npm 패키지 없음 |
| 설정 견본 | `on-client/.env.example` (비밀 없는 값: `ON_PORT=5189` 등). 실행 도구는 `.env`를 읽지 않으며, 기본 실행에는 `.env`가 필요 없음 |
| 경로 | 학생 파일(`student/extension.mjs`, 학생 README, 이 문서들)에 로컬 절대경로 없음. 실행 도구는 자기 위치 기준으로 앱 폴더를 찾음 |
| 비밀값 | 저장소에 없음. 계정 연결 자격은 프로젝트 밖 사용자 폴더에 보관(6장) |
| 외부 주소 | 공개 주소만 코드에 있음: CLCO 게이트, ALEPH 포털, OSV. SDP relay 주소는 운영자 개인 설정 파일에만 있음 |

제공 문서(`docs/AI_SETUP_GUIDE.md` 등)에는 `C:\AlekovPrivate\…` 같은 예시 경로가 있지만, 예시이며 코드가 의존하지 않습니다.

## 6. 데이터 보존 계획

| 데이터 | 위치 | 백업 | 복원 | 제한 |
|---|---|---|---|---|
| 학생 코드·문서 | Git 저장소(`main`), GitHub 원격 | 커밋 후 `git push` | 새 폴더에서 `git clone` 후 해당 커밋 `git checkout` | 2026-10-23에 저장소 기록을 정리해 그 이전 커밋(2026-10-06 작업)은 `main` 기록에서 제거됨. 제거된 기록은 이 저장소로 복원할 수 없음 |
| 계정 연결 설정·앱 자격 보관소 | `%USERPROFILE%\.aleph-keshev-<프로젝트 경로 SHA-256>` (실행 도구가 자동 생성, 프로젝트 밖) | 백업·복사하지 않음 | 새 폴더·새 PC에서는 실행 도구가 새 보관소를 만들고, 앱에서 계정 연결·AI 승인을 다시 진행 | 프로젝트 경로가 바뀌면 다른 보관소를 씀. Git·제출물에 넣지 않음. 학생이 임의로 지우거나 고치지 않음 |
| 보안 기록·판정·기기·세션 | 원천은 SDP 서버. 앱은 조회만 함 | 앱에서 백업하지 않음 | 연결 후 다시 조회 | 앱이 로컬에 저장하지 않음 |
| 조치 기록(SQLite) | 운영자가 `--alekov-actions` 설정으로 지정한 DB에만 생성 | 현재 사용 안 함 | 해당 없음 | 기본 실행에서는 만들지 않음 |
| 브라우저 데이터 | 없음 | 해당 없음 | 해당 없음 | 학생·제공 화면 모두 localStorage 등을 쓰지 않음 |
| `.env` | 저장소에 없음 | 비밀이 들어가므로 백업·커밋하지 않음 | 필요하면 `.env.example`을 참고해 새로 작성 | 기본 실행에는 필요 없음 |

## 7. 지원 범위와 미해결 사항

- **지원 환경**: Windows + PowerShell, Node.js 22~24(기준 24.19.0), PC 브라우저. macOS·Linux에서 실행 도구는 쓸 수 없습니다. Linux의 `node src/server.mjs` 실행은 3-1에서 연결 없음 상태로만 확인했습니다.
- **미해결·기다림(UNV)**: 계정 연결 확인(포털 결과 확인 불가), AI 앱 승인·verified 점검, 실제 AI 사건 설명, SDP 실제 로그인·판정·기록, 보안 조치 실집행과 결과 재조회(19단계 실집행 연결 미준비), OSV 실제 조회 결과, 학생 PC 새 환경 재현(3-2).
- 위 항목이 남아 있으므로 버전은 **검증 중**으로 기록합니다. OSV에 알려진 항목이 없다는 결과나 AI 설명만으로 안전을 보장하지 않습니다.
