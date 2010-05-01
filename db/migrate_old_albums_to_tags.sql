insert into tags (name)
select name from albums where parent_id is not null;

insert into photo_tags(photo_id, tag_id)
select p.id, t.id
from photos p inner join albums a on p.album_id = a.id
inner join tags t on a.name = t.name;

update photos
set album_id = 1;