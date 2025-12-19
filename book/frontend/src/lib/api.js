// src/lib/api.js
export const API_BASE = process.env.NEXT_PUBLIC_API_BASE || "/api";

// path는 "/user/login" 처럼 "/"로 시작하는 형태로 통일 권장
export function apiUrl(path) {
  if (!path.startsWith("/")) path = `/${path}`;
  return `${API_BASE}${path}`;
}

// JSON API용 fetch 래퍼 (필요 최소 옵션만)
export async function apiFetch(path, options = {}) {
  const res = await fetch(apiUrl(path), {
    ...options,
    headers: {
      "Content-Type": "application/json",
      ...(options.headers || {}),
    },
    // 쿠키 기반 인증을 쓸 거면 유지
    credentials: options.credentials ?? "include",
  });
  return res;
}

// 파일 업로드(FormData)용 fetch 래퍼
export async function apiFetchForm(path, formData, options = {}) {
  const res = await fetch(apiUrl(path), {
    method: options.method || "POST",
    body: formData,
    // FormData일 때 Content-Type 지정 금지
    credentials: options.credentials ?? "include",
    ...(options || {}),
  });
  return res;
}