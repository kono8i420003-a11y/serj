-- Запусти это в Supabase: Dashboard → SQL Editor → New query

create table if not exists applications (
    id         bigint generated always as identity primary key,
    name       text not null,
    phone      text not null,
    email      text,
    jump_type  text,
    created_at timestamptz default now()
);

-- Разрешить анонимным пользователям вставлять заявки (нужно для сайта)
alter table applications enable row level security;

create policy "allow anon insert"
    on applications
    for insert
    to anon
    with check (true);

-- Только авторизованные пользователи могут читать заявки
create policy "allow auth read"
    on applications
    for select
    to authenticated
    using (true);
