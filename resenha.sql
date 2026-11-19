-- Resenha: fotos, curtidas e comentários (Raquete de Quinta)
-- Rode uma vez no SQL Editor do Supabase.
alter table mural add column if not exists foto text;
alter table mural add column if not exists curtidas text[] not null default '{}';

create table if not exists comentarios (
  id uuid primary key default gen_random_uuid(),
  post_id uuid references mural(id) on delete cascade,
  autor text not null,
  texto text not null,
  created_at timestamptz not null default now()
);
alter table comentarios enable row level security;
drop policy if exists acesso_publico on comentarios;
create policy acesso_publico on comentarios for all to anon, authenticated using (true) with check (true);
grant select, insert, update, delete on comentarios to anon, authenticated;

-- pasta pública de fotos (até 5 MB por arquivo; o app já envia comprimido)
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('fotos', 'fotos', true, 5242880, array['image/jpeg','image/png','image/webp'])
on conflict (id) do nothing;
drop policy if exists fotos_ler on storage.objects;
drop policy if exists fotos_enviar on storage.objects;
drop policy if exists fotos_apagar on storage.objects;
create policy fotos_ler on storage.objects for select to anon, authenticated using (bucket_id = 'fotos');
create policy fotos_enviar on storage.objects for insert to anon, authenticated with check (bucket_id = 'fotos');
create policy fotos_apagar on storage.objects for delete to anon, authenticated using (bucket_id = 'fotos');
