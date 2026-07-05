-- Run this in Supabase Dashboard → SQL Editor
CREATE POLICY "Public Upload" ON storage.objects
  FOR INSERT TO anon
  WITH CHECK (bucket_id = 'profile_images');
