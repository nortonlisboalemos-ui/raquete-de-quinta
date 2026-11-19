-- Libera vídeos curtos na Resenha (até 50 MB por arquivo)
update storage.buckets
set file_size_limit = 52428800,
    allowed_mime_types = array['image/jpeg','image/png','image/webp','video/mp4','video/quicktime','video/webm']
where id = 'fotos';
