# defent_agent

학생 보안 Agent 「1q2w3e4r!」 프로젝트입니다. 앱 실행 폴더는 `on-client/`이고, 시작 틀 이름은 케셰브(KESHEV)입니다.
이 README는 학생이 작성했습니다. 시작 틀이 제공한 안내는 `on-client/README.md`에 있습니다.

## 목적

회사 직원이 자기 로그인 상태, 업무 앱 접근 판정, 최근 접속 기록과 XDR 경보, AI 설명, 보안 조치 상태, 설치 패키지의 알려진 취약점을 한 화면에서 확인하는 PC용 보안 앱입니다.
"확인된 것"과 "확인할 수 없는 것"을 구분해 보여 주는 것이 목표입니다. 확인 불가(unknown)·조회 실패·미조회는 정상이나 "문제 없음"으로 표시하지 않습니다.

## 기능

| 메뉴 | 기능 | 학생 구현 함수 |
|---|---|---|
| 보호 현황 | 로그인 사용자·기기·세션 표시 | `renderIdentity` |
| 보호 현황 | 기기·세션·알림·도움정보, 「도움정보 복사」 | `renderStatus` |
| 보호 현황 | 앱 내부 AI 연결 점검 결과 | `renderAiConnection` |
| 보호 현황 | 설치 패키지 버전과 OSV 알려진 취약점 | `renderVulnerabilities` |
| 업무 앱 | 업무 앱 접근 요청 결과(허용·거부·추가 확인·확인 불가) | `renderDecision` |
| 보안 기록 | 접속 기록·XDR 경보 목록, 필터, 상세(근거·규칙·상태) | `renderEvents` |
| 보안 기록 | 근거에 연결된 AI 사건 설명(참고용) | `renderExplanation` |
| 보안 기록 | 보안 조치 요청 상태와 실제 효과 구분 | `renderAction` |

모든 학생 구현은 `on-client/student/extension.mjs` 한 파일에 있습니다. 서버·제공 화면·판정·인증 코드는 시작 틀 그대로입니다.

## 구성

```text
브라우저(http://127.0.0.1:5189/)
  → 로컬 앱 서버(on-client/src/server.mjs)
      → 기존 접근 제어·XDR 서버(SDP relay, on-client/src/engine/sdp-host.mjs)
      → CLCO 수업용 AI 게이트(https://ai-classroom-gateway-production.up.railway.app)
      → package-lock.json 대조 후 OSV(https://api.osv.dev/v1/querybatch)
```

자세한 구성도(Mermaid·표), 실행 절차, 장애 안내, 확인 기록은 [on-client/docs/STUDENT_RUNBOOK.md](on-client/docs/STUDENT_RUNBOOK.md)에 있습니다.
새 환경 재현 결과, 버전·커밋 기록, 데이터 보존 계획은 [on-client/docs/STUDENT_RELEASE_RECORD.md](on-client/docs/STUDENT_RELEASE_RECORD.md)에 있습니다.

## 지원 환경과 버전

| 항목 | 값 |
|---|---|
| 앱 버전 | `alekov-client-starter` 0.2.14 (`on-client/package.json`) |
| 학생 버전 | 0.2.14-student.1 (검증 중 — 실제 연결·집행 등 미완료 항목 있음) |
| Node.js | 22~24, 수업 기준 24.19.0 (`engines.node`) |
| npm 의존성 | 없음(그래서 `package-lock.json` 없음) |
| 운영체제 | Windows + PowerShell (실행 도구 `on-client/tools/start-alekov.ps1`). macOS·Linux는 지원 환경 아님(Linux에서 `node src/server.mjs` 연결 없음 실행만 확인) |
| 실행 주소 | `http://127.0.0.1:5189/` (이 PC에서만 접속) |

## 빠른 실행

`on-client` 폴더에서 PowerShell을 열고 실행합니다.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\start-alekov.ps1
```

종료는 같은 창에서 `Ctrl+C`를 누릅니다. 계정·AI·SDP 실제 연결은 운영자 준비가 필요하며, 아직 확인하지 못한 항목은 실행 설명서의 「기다림(UNV)·미확인 목록」에 있습니다.

열쇠·토큰·비밀번호와 개인 설정 파일 내용은 이 저장소에 넣지 않습니다.
