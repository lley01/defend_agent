// 이 파일은 학생이 같은 프로젝트에서 이어서 구현합니다.
// 제공 UI를 받은 것만으로 단계 완료를 인정하지 않습니다.

// ---------- 13단계: 로그인 사용자·기기·세션 표시 (renderIdentity) ----------

const DEVICE_STATUS_LABELS = { compliant: '보안 기준 충족', noncompliant: '보안 기준 미충족', unknown: '확인 불가' };
const SESSION_STATUS_LABELS = { active: '활성', expired: '만료', revoked: '철회됨', unknown: '확인 불가' };
// 정상처럼 보이면 안 되는 상태. 색상과 함께 '주의' 문구로도 구분한다.
const WARNING_STATUSES = new Set(['noncompliant', 'expired', 'revoked']);
const MODE_NOTES = { demo: '예제 자료(demo) · 실제 연결 아님', disconnected: '연결 없음', unknown: '확인 불가: 연결 상태를 확인할 수 없음' };
// 응답 형식을 검증하지 못한 오류는 연결 실패가 아니라 확인 불가로 표시한다.
const UNVERIFIED_CODES = new Set(['CONTRACT_MISMATCH', 'ENGINE_RESULT_UNVERIFIED']);

function createNode(tag, className, text) {
  const node = document.createElement(tag);
  if (className) node.className = className;
  if (text != null) node.textContent = String(text);
  return node;
}

// 상태값을 "한국어(원래 값)"으로 표시하고, 상태 종류를 글자로도 드러낸다.
function statusBadge(labels, value) {
  const known = typeof value === 'string' && Object.hasOwn(labels, value);
  const label = known ? labels[value] : '확인 불가';
  const raw = typeof value === 'string' ? value : 'unknown';
  if (known && WARNING_STATUSES.has(value)) return createNode('span', 'tag state-error', `주의 · ${label}(${raw})`);
  if (!known || value === 'unknown') return createNode('span', 'tag state-empty', `${label}(${raw})`);
  return createNode('span', 'tag state-ok', `${label}(${raw})`);
}

// loading·error 상태에서도 전달받은 demo·disconnected·unknown 모드 안내를 함께 표시한다.
function modeNote(mode) {
  if (typeof mode !== 'string' || !Object.hasOwn(MODE_NOTES, mode)) return null;
  return createNode('p', mode === 'demo' ? 'state tag-demo' : 'state state-empty', `데이터 상태: ${MODE_NOTES[mode]}`);
}

function failureText(error) {
  const code = error && typeof error.code === 'string' ? error.code : '';
  const message = error && typeof error.message === 'string' && error.message ? error.message : '서버 메시지 없음';
  return `${UNVERIFIED_CODES.has(code) ? '확인 불가' : '연결 실패'}: ${message}`;
}

// 항목 하나(me·devices·sessions)의 영역. ok가 아닐 때는 data를 읽지 않으므로 이전 값이 남지 않는다.
function identityPart(title, resource, renderOk) {
  const part = createNode('section', 'identity-part');
  part.append(createNode('h3', null, title));
  const status = resource && resource.status;
  if (status === 'loading') {
    const box = createNode('p', 'state state-loading', '불러오는 중…');
    box.setAttribute('role', 'status');
    part.append(box);
  } else if (status === 'error') {
    const box = createNode('p', 'state state-error', failureText(resource.error));
    box.setAttribute('role', 'alert');
    part.append(box);
  } else if (status === 'ok') {
    part.append(renderOk(resource.data));
  } else {
    part.append(createNode('p', 'state state-empty', '확인 불가: 알 수 없는 응답 상태'));
  }
  const note = modeNote(resource && resource.mode);
  if (note) part.append(note);
  return part;
}

function describedRow(list, term, ...values) {
  list.append(createNode('dt', null, term));
  const dd = createNode('dd');
  for (const value of values) dd.append(typeof value === 'string' ? document.createTextNode(value) : value);
  list.append(dd);
}

// me.data: { user:{id,label}, device:{id,label,status}, session:{id,status} }
function renderMe(data) {
  const list = createNode('dl', 'identity-me');
  describedRow(list, '사용자', `${data.user.label} (ID: ${data.user.id})`);
  describedRow(list, '현재 기기', `${data.device.label} (ID: ${data.device.id}) `, statusBadge(DEVICE_STATUS_LABELS, data.device.status));
  describedRow(list, '현재 세션', `ID: ${data.session.id} `, statusBadge(SESSION_STATUS_LABELS, data.session.status));
  return list;
}

// devices.data: [{ id, label, status }]
function renderDeviceList(data) {
  if (data.length === 0) return createNode('p', 'state state-empty', '등록된 기기가 없습니다.');
  const list = createNode('ul', 'identity-devices');
  for (const device of data) {
    const item = createNode('li', null, `${device.label} (ID: ${device.id}) `);
    item.append(statusBadge(DEVICE_STATUS_LABELS, device.status));
    list.append(item);
  }
  return list;
}

// sessions.data: [{ id, status }]
function renderSessionList(data) {
  if (data.length === 0) return createNode('p', 'state state-empty', '표시할 세션이 없습니다.');
  const list = createNode('ul', 'identity-sessions');
  for (const session of data) {
    const item = createNode('li', null, `세션 ID: ${session.id} `);
    item.append(statusBadge(SESSION_STATUS_LABELS, session.status));
    list.append(item);
  }
  return list;
}

// 호출마다 새 요소를 만들어 반환한다. 제공 UI가 슬롯 내용을 이 요소로 교체하므로,
// 다시 불러오기로 새 값이 오면 이전 사용자·기기·세션 표시는 남지 않는다.
function renderIdentity(input) {
  const { me, devices, sessions } = input || {};
  const root = createNode('div', 'student-identity');
  root.append(
    identityPart('로그인 정보', me, renderMe),
    identityPart('등록 기기', devices, renderDeviceList),
    identityPart('세션', sessions, renderSessionList),
  );
  return root;
}

export function createStudentView() {
  return {
    renderIdentity,
    renderDecision() { return '학생 구현 대기: 서버의 판정과 이유를 연결하세요.'; },
    renderEvents() { return '학생 구현 대기: 본인 접속·XDR 기록을 연결하세요.'; },
    renderStatus() { return '학생 구현 대기: 기기·세션·알림과 연결 점검 상태를 구분하세요.'; },
    renderVulnerabilities() { return '학생 구현 대기: 정확한 설치 버전·OSV 출처·조회 시각·부분 결과·조회 실패를 구분하세요.'; },
    renderAiConnection() { return '학생 구현 대기: 모델 응답 점검과 실제 사건 설명을 구분하고 AI 오류·취소·수동 복구를 안내하세요.'; },
    renderExplanation() { return '학생 구현 대기: 선택한 사건의 근거·규칙·현재 상태와 AI 설명을 연결하세요. 제안은 자동 실행하지 않습니다.'; },
    renderAction() { return '학생 구현 대기: 현재 사건·조치·실제 대상·사람 확인·ACK와 원천 효과·unknown을 구분하세요.'; },
  };
}
