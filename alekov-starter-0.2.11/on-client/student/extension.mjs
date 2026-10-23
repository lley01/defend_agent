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

// ---------- 14단계: 업무 앱 접근 요청 결과 표시 (renderDecision) ----------

// allow는 정책상 접근 허용일 뿐 실제 앱 접속 성공을 보장하지 않는다.
const DECISION_INFO = {
  allow: { label: '접근 허용', className: 'decision decision-allow', note: '정책상 접근이 허용되었습니다. 실제 앱 접속 성공을 보장하지 않습니다.' },
  deny: { label: '접근 거부', className: 'decision decision-deny', note: '정책에 따라 접근이 거부되었습니다.' },
  challenge: { label: '추가 확인 필요', className: 'decision decision-challenge', note: '허용되지 않음: 추가 인증 또는 확인이 필요합니다. 이 앱이 확인 절차를 대신 수행하지 않습니다.' },
  unknown: { label: '판정 확인 불가', className: 'decision decision-unknown', note: '허용되지 않음: 서버가 판정을 확인하지 못했습니다. 접근 허용으로 간주하지 마세요.' },
};

function formatCheckedAt(value) {
  if (typeof value !== 'string' || !value) return '판정 시각 정보 없음';
  const time = new Date(value);
  return Number.isNaN(time.getTime()) ? `확인 불가(${value})` : `${time.toLocaleString('ko-KR')} (${value})`;
}

function decisionResult(data, appId) {
  const box = createNode('div', 'decision-result');
  const decision = data && data.decision;
  const known = typeof decision === 'string' && Object.hasOwn(DECISION_INFO, decision);
  // 목록에 없는 값은 unknown과 똑같이 확인 불가로 처리한다(허용으로 보이지 않게).
  const info = known ? DECISION_INFO[decision] : DECISION_INFO.unknown;
  const code = known ? decision : 'unknown';
  const heading = createNode('p', info.className);
  heading.append(createNode('strong', null, `${info.label}(${code})`));
  heading.append(document.createTextNode(` · 앱 ${(data && data.appId) || appId || 'ID 없음'}`));
  box.append(heading, createNode('p', null, info.note));
  if (!known) box.append(createNode('p', 'muted', `받은 판정 값: ${decision == null ? '없음' : String(decision)}`));
  const list = createNode('dl', 'kv');
  describedRow(list, '판정 이유', data && typeof data.reason === 'string' && data.reason ? data.reason : '판정 이유 정보 없음');
  describedRow(list, '판정 시각', formatCheckedAt(data && data.checkedAt));
  box.append(list);
  return box;
}

// 요청 실패는 서버의 판정이 아니다. 거부·허용 어느 쪽으로도 읽히지 않게 한다.
function decisionFailure(error, appId) {
  const box = createNode('div', 'decision-result');
  const heading = createNode('p', 'decision decision-failed');
  heading.setAttribute('role', 'alert');
  heading.append(createNode('strong', null, '요청 실패'));
  heading.append(document.createTextNode(` · 앱 ${appId || 'ID 없음'}`));
  const message = error && typeof error.message === 'string' && error.message ? error.message : '서버 메시지 없음';
  box.append(
    heading,
    createNode('p', null, `요청 실패: ${message}`),
    createNode('p', 'muted', '허용되지 않음: 판정을 받지 못했습니다. 이것은 접근 거부 판정이 아닙니다. 필요하면 앱을 골라 다시 요청하세요.'),
  );
  return box;
}

// 입력: { status, mode, data?, error?, appId }. 호출마다 새 요소를 반환한다.
function renderDecision(input) {
  const { status, mode, data, error, appId } = input || {};
  const root = createNode('div', 'student-decision');
  if (status === 'idle') {
    root.append(createNode('p', 'muted', '앱을 골라 접속을 요청하세요.'));
  } else if (status === 'loading') {
    const box = createNode('p', 'state state-loading', `판정 확인 중… (앱 ${appId || 'ID 없음'})`);
    box.setAttribute('role', 'status');
    root.append(box);
  } else if (status === 'ok') {
    root.append(decisionResult(data, appId));
  } else if (status === 'error') {
    root.append(decisionFailure(error, appId));
  } else {
    root.append(createNode('p', 'decision decision-unknown', '확인 불가(unknown): 알 수 없는 요청 상태입니다. 접근 허용으로 간주하지 마세요.'));
  }
  const note = modeNote(mode);
  if (note) root.append(note);
  return root;
}

// ---------- 15단계: 접속 기록·XDR 경보 목록과 상세 보기 (renderEvents) ----------
// 관측 범위: 앱 서버가 SDP 감사 기록에서 현재 등록 정보와 맞춰 본 본인의 최근 기록(최대 40건)과
// 서버에 이미 저장된 XDR 경보만이다. 화면을 열 때 새로 탐지하지 않는다.

const EVENT_KIND_LABELS = { access: '접속 기록', xdr: 'XDR 경보' };
const ACCESS_STATE_LABELS = { allowed: '접근 허용', denied: '접근 거부', unknown: '확인 불가' };
const ALL = 'all';
const NO_APP = ''; // appId 없는 기록을 고르는 필터 값

function kindText(kind) {
  return Object.hasOwn(EVENT_KIND_LABELS, kind) ? `${EVENT_KIND_LABELS[kind]}(${kind})` : `확인 불가(${String(kind)})`;
}

function appText(appId) {
  return typeof appId === 'string' && appId ? appId : '앱 확인 불가(appId 없음)';
}

function eventTime(at) {
  const time = typeof at === 'string' ? new Date(at) : null;
  if (!time || Number.isNaN(time.getTime())) return `시각 확인 불가(${String(at)})`;
  return `${time.toLocaleString('ko-KR')} (${at})`;
}

function accessBadge(value) {
  const known = typeof value === 'string' && Object.hasOwn(ACCESS_STATE_LABELS, value);
  if (!known || value === 'unknown') return createNode('span', 'tag state-empty', `확인 불가(${known ? value : 'unknown'})`);
  if (value === 'denied') return createNode('span', 'tag state-error', `주의 · ${ACCESS_STATE_LABELS[value]}(${value})`);
  return createNode('span', 'tag state-ok', `${ACCESS_STATE_LABELS[value]}(${value})`);
}

// 받은 배열을 복사해 at 기준 최신순으로 정렬한다. 원본은 수정하지 않는다. 시각을 읽을 수 없는 기록은 뒤로 보낸다.
function sortEventsNewestFirst(data) {
  const time = (event) => {
    const ms = Date.parse(event && event.at);
    return Number.isFinite(ms) ? ms : -Infinity;
  };
  return [...data].sort((a, b) => time(b) - time(a));
}

// 행: 사건 ID·시각·종류·앱·요약과 「<event.id> 상세」 버튼
function eventRow(event, isOpen, onToggle) {
  const item = createNode('li', 'student-event');
  item.dataset.studentEventId = event.id;
  item.append(createNode('p', null, `${kindText(event.kind)} · ${event.summary || '요약 없음'}`));
  const meta = createNode('dl', 'kv');
  describedRow(meta, '사건 ID', String(event.id));
  describedRow(meta, '시각', eventTime(event.at));
  describedRow(meta, '종류', kindText(event.kind));
  describedRow(meta, '앱', appText(event.appId));
  item.append(meta);
  const button = createNode('button', 'btn', `${event.id} 상세`);
  button.type = 'button';
  button.setAttribute('aria-expanded', String(isOpen));
  button.addEventListener('click', () => onToggle(event, item, button));
  item.append(button);
  return item;
}

function textEntries(title, entries) {
  const block = createNode('div', 'event-block');
  block.append(createNode('h4', null, title));
  if (!Array.isArray(entries) || entries.length === 0) {
    block.append(createNode('p', 'muted', '없음'));
    return block;
  }
  const list = createNode('ul');
  for (const entry of entries) list.append(createNode('li', null, `${entry.id}: ${entry.text}`));
  block.append(list);
  return block;
}

// 상세: 사건 ID·appId·근거·규칙·세 상태(원래 값과 한국어 설명). 조치 버튼은 만들지 않는다(16단계).
function eventDetail(event) {
  const detail = createNode('section', 'student-event-detail');
  detail.dataset.studentEventDetail = event.id;
  detail.append(createNode('h4', null, `${event.id} 상세`));
  const meta = createNode('dl', 'kv');
  describedRow(meta, '사건 ID', String(event.id));
  describedRow(meta, '앱', appText(event.appId));
  detail.append(meta, textEntries('근거(evidence)', event.evidence), textEntries('규칙(rules)', event.rules));
  const state = event.state || {};
  const states = createNode('dl', 'kv');
  describedRow(states, '접속 상태', accessBadge(state.access));
  describedRow(states, '세션 상태', statusBadge(SESSION_STATUS_LABELS, state.session));
  describedRow(states, '기기 상태', statusBadge(DEVICE_STATUS_LABELS, state.device));
  detail.append(createNode('h4', null, '상태(state)'), states);
  // 16단계: 연결되지 않은 조치가 넘어온 경우에만 「<action> 미지원」 비활성 버튼을 둔다.
  // 버튼은 비활성이며 어떤 요청도 보내지 않는다. 실제 목록처럼 비어 있으면 아무것도 만들지 않는다.
  const actions = Array.isArray(event.supportedActions) ? event.supportedActions : [];
  if (actions.length > 0) {
    const block = createNode('div', 'student-unsupported-actions');
    block.append(createNode('h4', null, '조치'));
    for (const action of actions) {
      const button = createNode('button', 'btn', `${action} 미지원`);
      button.type = 'button';
      button.disabled = true;
      button.setAttribute('aria-disabled', 'true');
      block.append(button);
    }
    block.append(createNode('p', 'muted', '아직 지원하지 않는 조치입니다. 조치 실행 연결은 준비 중이며, 이 버튼은 요청을 보내지 않습니다.'));
    detail.append(block);
  }
  return detail;
}

function filterSelect(id, labelText, options, onChange) {
  const wrap = createNode('div', 'student-filter');
  const label = createNode('label', null, labelText);
  label.htmlFor = id;
  const select = createNode('select');
  select.id = id;
  select.append(Object.assign(createNode('option', null, '전체'), { value: ALL }));
  for (const [value, text] of options) select.append(Object.assign(createNode('option', null, text), { value }));
  select.addEventListener('change', onChange);
  wrap.append(label, select);
  return { wrap, select };
}

function uniqueValues(events, pick) {
  return [...new Set(events.map(pick))].sort();
}

// 입력: { status, mode, data?, error? }. 호출마다 필터·상세 선택을 초기화한 새 요소를 반환한다.
// 필터와 상세는 받은 배열 안에서만 처리하고 서버에 다시 묻지 않는다.
function renderEvents(input) {
  const { status, mode, data, error } = input || {};
  const root = createNode('div', 'student-events');
  const finish = () => {
    const note = modeNote(mode);
    if (note) root.append(note);
    return root;
  };
  if (status === 'loading') {
    const box = createNode('p', 'state state-loading', '불러오는 중…');
    box.setAttribute('role', 'status');
    root.append(box);
    return finish();
  }
  if (status === 'error') {
    const message = error && typeof error.message === 'string' && error.message ? error.message : '서버 메시지 없음';
    const unverified = error && UNVERIFIED_CODES.has(error.code);
    const box = createNode('p', 'state state-error', unverified
      ? `확인 불가: 기록 응답을 확인할 수 없습니다. 이전 목록을 표시하지 않습니다. ${message}`
      : `기록을 불러오지 못했습니다: ${message}`);
    box.setAttribute('role', 'alert');
    root.append(box);
    return finish();
  }
  if (status !== 'ok' || !Array.isArray(data)) {
    root.append(createNode('p', 'state state-empty', '확인 불가: 알 수 없는 응답 상태입니다.'));
    return finish();
  }
  if (data.length === 0) {
    root.append(createNode('p', 'state state-empty', '표시할 기록이 없습니다.'));
    return finish();
  }

  const events = sortEventsNewestFirst(data);
  let openId = null; // 상세로 연 기록. 새 호출(다시 불러오기)마다 초기화된다.

  const kind = filterSelect('student-events-filter-kind', '기록 종류',
    uniqueValues(events, (e) => e.kind).map((v) => [v, kindText(v)]), () => draw());
  const app = filterSelect('student-events-filter-app', '업무 앱',
    uniqueValues(events, (e) => (typeof e.appId === 'string' && e.appId ? e.appId : NO_APP)).map((v) => [v, appText(v)]), () => draw());
  const access = filterSelect('student-events-filter-access', '접속 상태',
    uniqueValues(events, (e) => e.state && e.state.access).map((v) => [v, `${Object.hasOwn(ACCESS_STATE_LABELS, v) ? ACCESS_STATE_LABELS[v] : '확인 불가'}(${v})`]), () => draw());
  const filters = createNode('div', 'row student-event-filters');
  filters.append(kind.wrap, app.wrap, access.wrap);

  const count = createNode('p', 'muted');
  count.setAttribute('role', 'status');
  const list = createNode('ul', 'student-event-list');
  root.append(filters, count, list);

  const matches = (event) =>
    (kind.select.value === ALL || event.kind === kind.select.value)
    && (app.select.value === ALL || (typeof event.appId === 'string' && event.appId ? event.appId : NO_APP) === app.select.value)
    && (access.select.value === ALL || (event.state && event.state.access) === access.select.value);

  // 같은 버튼을 다시 누르면 닫고, 다른 기록을 열면 이전 상세를 지운다.
  function toggle(event, item, button) {
    for (const old of list.querySelectorAll('.student-event-detail')) old.remove();
    for (const other of list.querySelectorAll('button[aria-expanded="true"]')) other.setAttribute('aria-expanded', 'false');
    if (openId === event.id) { openId = null; return; }
    openId = event.id;
    button.setAttribute('aria-expanded', 'true');
    item.append(eventDetail(event));
  }

  function draw() {
    const shown = events.filter(matches);
    if (!shown.some((event) => event.id === openId)) openId = null; // 걸러진 기록의 상세는 남기지 않는다.
    count.textContent = `표시 ${shown.length}건 / 받은 기록 ${events.length}건`;
    list.replaceChildren();
    if (shown.length === 0) {
      list.append(createNode('li', 'state state-empty', '필터 조건에 맞는 기록이 없습니다.'));
      return;
    }
    for (const event of shown) {
      const item = eventRow(event, event.id === openId, toggle);
      if (event.id === openId) item.append(eventDetail(event));
      list.append(item);
    }
  }

  draw();
  return finish();
}

// ---------- 16단계: 알림·빈 상태·오류·진단 정보 (renderStatus) ----------
// 다시 시도는 사용자가 위쪽 「다시 불러오기」 버튼을 직접 누를 때만 일어난다. 이 함수는 어떤 요청도 보내지 않는다.

const RESOURCE_NAMES = {
  me: '로그인 정보', apps: '업무 앱', events: '보안 기록', devices: '등록 기기', sessions: '현재 세션',
  access: '접속 판정', diagnostics: '도움정보', vulnerabilities: '설치 패키지 조회',
};
const TIMEOUT_CODES = new Set(['TIMEOUT', 'ENGINE_TIMEOUT', 'REQUEST_TIMEOUT']);
const RETRY_GUIDE = '다시 시도는 위쪽 「다시 불러오기」 버튼을 직접 누르세요. 자동으로 다시 요청하지 않습니다.';
// 진단 값이 키·토큰·비밀번호처럼 보이면 화면과 복사 내용에 쓰지 않는다.
const SECRET_PATTERN = /(?:Bearer\s+\S+|sk-[A-Za-z0-9_-]{8,}|-----BEGIN [A-Z ]*PRIVATE KEY-----|eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]+|(?:api[_ -]?key|authorization|password|secret|token|비밀번호|토큰)\s*[:=])/i;

function resourceName(resource) {
  return Object.hasOwn(RESOURCE_NAMES, resource) ? `${RESOURCE_NAMES[resource]}(${resource})` : `확인 불가(${String(resource)})`;
}

function statusFailure(subject, error) {
  const code = error && typeof error.code === 'string' ? error.code : '';
  const message = error && typeof error.message === 'string' && error.message ? error.message : '서버 메시지 없음';
  const reason = TIMEOUT_CODES.has(code) ? '시간 초과 · ' : UNVERIFIED_CODES.has(code) ? '확인 불가(응답 형식) · ' : '';
  const box = createNode('div', 'student-failure');
  const head = createNode('p', 'state state-error', `${reason}${subject} 불러오지 못했습니다: ${message}`);
  head.setAttribute('role', 'alert');
  box.append(head, createNode('p', 'muted', RETRY_GUIDE));
  return box;
}

// devices·sessions 각각: 불러오는 중 / 빈 목록 / 실패 / 목록을 서로 다른 문장으로 표시한다.
function statusPart(title, subject, resource, emptyText, renderItem, scopeNote) {
  const part = createNode('section', 'status-part');
  part.append(createNode('h3', null, title));
  if (scopeNote) part.append(createNode('p', 'muted', scopeNote));
  const status = resource && resource.status;
  if (status === 'loading') {
    const box = createNode('p', 'state state-loading', `${subject} 불러오는 중…`);
    box.setAttribute('role', 'status');
    part.append(box);
  } else if (status === 'error') {
    part.append(statusFailure(subject, resource.error));
  } else if (status === 'ok' && Array.isArray(resource.data)) {
    if (resource.data.length === 0) part.append(createNode('p', 'state state-empty', emptyText));
    else {
      const list = createNode('ul');
      for (const row of resource.data) list.append(renderItem(row));
      part.append(list);
    }
  } else {
    part.append(createNode('p', 'state state-empty', `확인 불가: ${title} 응답 상태를 알 수 없습니다.`));
  }
  const note = modeNote(resource && resource.mode);
  if (note) part.append(note);
  return part;
}

function notificationPart(notifications) {
  const part = createNode('section', 'status-part');
  part.append(createNode('h3', null, '알림'));
  if (!Array.isArray(notifications) || notifications.length === 0) {
    part.append(createNode('p', 'state state-ok', '주의할 알림이 없습니다.'));
    return part;
  }
  const list = createNode('ul', 'student-notifications');
  for (const item of notifications) {
    const row = createNode('li');
    row.append(
      createNode('strong', null, `주의 · ${resourceName(item && item.resource)}`),
      document.createTextNode(` · 코드 ${item && typeof item.code === 'string' ? item.code : '없음'} · ${item && item.message ? item.message : '메시지 없음'}`),
    );
    list.append(row);
  }
  part.append(createNode('p', null, `주의할 알림 ${notifications.length}건`), list);
  return part;
}

// 진단 결과에서 지정한 6개 값만 꺼낸다. 다른 필드(ai 설정 등)는 읽지 않는다.
function safeDiagnostics(data) {
  const engine = data && typeof data.engine === 'object' && data.engine ? data.engine : {};
  const pick = (value) => {
    if (typeof value !== 'string' || !value) return '확인 불가(값 없음)';
    if (SECRET_PATTERN.test(value)) return '[비밀값으로 보여 표시하지 않음]';
    return value.slice(0, 200);
  };
  return [
    ['requestId', pick(data && data.requestId)],
    ['component', pick(data && data.component)],
    ['version', pick(data && data.version)],
    ['checkedAt', pick(data && data.checkedAt)],
    ['engine.mode', pick(engine.mode)],
    ['engine.code', pick(engine.code)],
  ];
}

function diagnosticsPart(diagnostics) {
  const part = createNode('section', 'status-part');
  part.append(createNode('h3', null, '도움정보'));
  const status = diagnostics && diagnostics.status;
  let rows = null;
  if (status === 'idle') {
    part.append(createNode('p', 'muted', '도움정보를 아직 불러오지 않았습니다. 필요하면 아래 「도움정보 불러오기」 버튼을 직접 누르세요.'));
  } else if (status === 'loading') {
    const box = createNode('p', 'state state-loading', '도움정보를 불러오는 중…');
    box.setAttribute('role', 'status');
    part.append(box);
  } else if (status === 'error') {
    const failure = statusFailure('도움정보를', diagnostics.error);
    failure.lastChild.textContent = '다시 시도는 아래 「도움정보 불러오기」 버튼을 직접 누르세요. 자동으로 다시 요청하지 않습니다.';
    part.append(failure);
  } else if (status === 'ok') {
    rows = safeDiagnostics(diagnostics.data);
    const list = createNode('dl', 'kv');
    for (const [key, value] of rows) describedRow(list, key, value);
    part.append(list);
  } else {
    part.append(createNode('p', 'state state-empty', '확인 불가: 도움정보의 응답 상태를 알 수 없습니다.'));
  }

  // 「도움정보 복사」: 도움 요청에 붙여 넣을 수 있도록, 사용자가 누를 때만 위의 안전한 값만 복사한다.
  const copy = createNode('button', 'btn', '도움정보 복사');
  copy.type = 'button';
  const result = createNode('p', 'muted', rows
    ? '도움 요청에 쓰도록 위의 6개 값만 복사합니다. 비밀번호·토큰·API 키는 포함하지 않습니다.'
    : '도움정보를 불러온 뒤에 복사할 수 있습니다.');
  result.setAttribute('role', 'status');
  if (!rows) copy.disabled = true;
  copy.addEventListener('click', async () => {
    if (!rows) return;
    const text = rows.map(([key, value]) => `${key}: ${value}`).join('\n');
    try {
      if (!navigator.clipboard || typeof navigator.clipboard.writeText !== 'function') throw new Error('unavailable');
      await navigator.clipboard.writeText(text);
      result.textContent = '도움정보 6개 값을 클립보드에 복사했습니다. 붙여 넣기 전에 내용을 확인하세요.';
    } catch {
      result.textContent = '자동 복사를 사용할 수 없습니다. 위의 값을 직접 선택해 Ctrl+C로 복사하세요.';
    }
  });
  part.append(copy, result);
  return part;
}

// 입력: { devices, sessions, notifications, diagnostics, mode }. 호출마다 새 요소를 반환하므로
// 다시 불러와 성공하면 이전 실패 안내는 남지 않는다.
function renderStatus(input) {
  const { devices, sessions, notifications, diagnostics, mode } = input || {};
  const root = createNode('div', 'student-status');
  root.append(
    statusPart('등록 기기', '등록 기기 목록을', devices, '등록된 기기가 없습니다.', (device) => {
      const item = createNode('li', null, `${device.label} (ID: ${device.id}) `);
      item.append(statusBadge(DEVICE_STATUS_LABELS, device.status));
      return item;
    }),
    statusPart('현재 세션', '현재 세션 정보를', sessions, '현재 연결이 없습니다.', (session) => {
      const item = createNode('li', null, `세션 ID: ${session.id} `);
      item.append(statusBadge(SESSION_STATUS_LABELS, session.status));
      return item;
    }, '현재 검증된 연결 1건만 표시합니다. 지난 세션 목록이 아닙니다.'),
    notificationPart(notifications),
    diagnosticsPart(diagnostics),
  );
  const note = modeNote(mode);
  if (note) root.append(note);
  return root;
}

export function createStudentView() {
  return {
    renderIdentity,
    renderDecision,
    renderEvents,
    renderStatus,
    renderVulnerabilities() { return '학생 구현 대기: 정확한 설치 버전·OSV 출처·조회 시각·부분 결과·조회 실패를 구분하세요.'; },
    renderAiConnection() { return '학생 구현 대기: 모델 응답 점검과 실제 사건 설명을 구분하고 AI 오류·취소·수동 복구를 안내하세요.'; },
    renderExplanation() { return '학생 구현 대기: 선택한 사건의 근거·규칙·현재 상태와 AI 설명을 연결하세요. 제안은 자동 실행하지 않습니다.'; },
    renderAction() { return '학생 구현 대기: 현재 사건·조치·실제 대상·사람 확인·ACK와 원천 효과·unknown을 구분하세요.'; },
  };
}
