
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 00 c6 10 80       	mov    $0x8010c600,%esp
8010002d:	b8 90 31 10 80       	mov    $0x80103190,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 34 c6 10 80       	mov    $0x8010c634,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 76 10 80       	push   $0x801076a0
80100051:	68 00 c6 10 80       	push   $0x8010c600
80100056:	e8 65 48 00 00       	call   801048c0 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 4c 0d 11 80 fc 	movl   $0x80110cfc,0x80110d4c
80100062:	0c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 50 0d 11 80 fc 	movl   $0x80110cfc,0x80110d50
8010006c:	0c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba fc 0c 11 80       	mov    $0x80110cfc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 fc 0c 11 80 	movl   $0x80110cfc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 76 10 80       	push   $0x801076a7
80100097:	50                   	push   %eax
80100098:	e8 f3 46 00 00       	call   80104790 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 50 0d 11 80       	mov    0x80110d50,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 50 0d 11 80    	mov    %ebx,0x80110d50

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d fc 0c 11 80       	cmp    $0x80110cfc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 00 c6 10 80       	push   $0x8010c600
801000e4:	e8 37 49 00 00       	call   80104a20 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 50 0d 11 80    	mov    0x80110d50,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 4c 0d 11 80    	mov    0x80110d4c,%ebx
80100126:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 00 c6 10 80       	push   $0x8010c600
80100162:	e8 69 49 00 00       	call   80104ad0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 5e 46 00 00       	call   801047d0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 9d 22 00 00       	call   80102420 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 ae 76 10 80       	push   $0x801076ae
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 bd 46 00 00       	call   80104870 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 57 22 00 00       	jmp    80102420 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 bf 76 10 80       	push   $0x801076bf
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 7c 46 00 00       	call   80104870 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 46 00 00       	call   80104830 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
8010020b:	e8 10 48 00 00       	call   80104a20 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 50 0d 11 80       	mov    0x80110d50,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 fc 0c 11 80 	movl   $0x80110cfc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 50 0d 11 80       	mov    0x80110d50,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 50 0d 11 80    	mov    %ebx,0x80110d50
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 00 c6 10 80 	movl   $0x8010c600,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 6f 48 00 00       	jmp    80104ad0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 c6 76 10 80       	push   $0x801076c6
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 fb 17 00 00       	call   80101a80 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 60 b5 10 80 	movl   $0x8010b560,(%esp)
8010028c:	e8 8f 47 00 00       	call   80104a20 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 e0 0f 11 80       	mov    0x80110fe0,%eax
801002a6:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 60 b5 10 80       	push   $0x8010b560
801002b8:	68 e0 0f 11 80       	push   $0x80110fe0
801002bd:	e8 ae 3d 00 00       	call   80104070 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 e0 0f 11 80       	mov    0x80110fe0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 e9 37 00 00       	call   80103ac0 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 60 b5 10 80       	push   $0x8010b560
801002e6:	e8 e5 47 00 00       	call   80104ad0 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 ad 16 00 00       	call   801019a0 <ilock>
        return -1;
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 e0 0f 11 80    	mov    %edx,0x80110fe0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 60 0f 11 80 	movsbl -0x7feef0a0(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 60 b5 10 80       	push   $0x8010b560
80100346:	e8 85 47 00 00       	call   80104ad0 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 4d 16 00 00       	call   801019a0 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 e0 0f 11 80       	mov    %eax,0x80110fe0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100379:	c7 05 94 b5 10 80 00 	movl   $0x0,0x8010b594
80100380:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100389:	e8 92 26 00 00       	call   80102a20 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 cd 76 10 80       	push   $0x801076cd
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 53 81 10 80 	movl   $0x80108153,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 23 45 00 00       	call   801048e0 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 e1 76 10 80       	push   $0x801076e1
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003d9:	c7 05 98 b5 10 80 01 	movl   $0x1,0x8010b598
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 15 98 b5 10 80    	mov    0x8010b598,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 31 5e 00 00       	call   80106250 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c1                	mov    %eax,%ecx
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 f2                	mov    %esi,%edx
80100449:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 

  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100492:	89 fb                	mov    %edi,%ebx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 d8                	mov    %ebx,%eax
801004bd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 78 5d 00 00       	call   80106250 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 6c 5d 00 00       	call   80106250 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 60 5d 00 00       	call   80106250 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fe:	68 60 0e 00 00       	push   $0xe60
80100503:	68 a0 80 0b 80       	push   $0x800b80a0
80100508:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	e8 b7 46 00 00       	call   80104bd0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 f2 45 00 00       	call   80104b20 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 e5 76 10 80       	push   $0x801076e5
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010055a:	31 db                	xor    %ebx,%ebx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100590:	74 0c                	je     8010059e <printint+0x1e>
80100592:	89 c7                	mov    %eax,%edi
80100594:	c1 ef 1f             	shr    $0x1f,%edi
80100597:	85 c0                	test   %eax,%eax
80100599:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010059c:	78 51                	js     801005ef <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
8010059e:	31 ff                	xor    %edi,%edi
801005a0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005a3:	eb 05                	jmp    801005aa <printint+0x2a>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005a8:	89 cf                	mov    %ecx,%edi
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 4f 01             	lea    0x1(%edi),%ecx
801005af:	f7 f6                	div    %esi
801005b1:	0f b6 92 10 77 10 80 	movzbl -0x7fef88f0(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>

  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005cb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ce:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005d8:	0f be 06             	movsbl (%esi),%eax
801005db:	83 ee 01             	sub    $0x1,%esi
801005de:	e8 0d fe ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005e3:	39 de                	cmp    %ebx,%esi
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
    consputc(buf[i]);
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ef:	f7 d8                	neg    %eax
801005f1:	eb ab                	jmp    8010059e <printint+0x1e>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060f:	e8 6c 14 00 00       	call   80101a80 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 60 b5 10 80 	movl   $0x8010b560,(%esp)
8010061b:	e8 00 44 00 00       	call   80104a20 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010063b:	39 df                	cmp    %ebx,%edi
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 60 b5 10 80       	push   $0x8010b560
80100647:	e8 84 44 00 00       	call   80104ad0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 4b 13 00 00       	call   801019a0 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100669:	a1 94 b5 10 80       	mov    0x8010b594,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 47 01 00 00    	jne    801007c0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c1                	mov    %eax,%ecx
80100680:	0f 84 4f 01 00 00    	je     801007d5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
80100689:	31 db                	xor    %ebx,%ebx
8010068b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010068e:	89 cf                	mov    %ecx,%edi
80100690:	85 c0                	test   %eax,%eax
80100692:	75 55                	jne    801006e9 <cprintf+0x89>
80100694:	eb 68                	jmp    801006fe <cprintf+0x9e>
80100696:	8d 76 00             	lea    0x0(%esi),%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006a0:	83 c3 01             	add    $0x1,%ebx
801006a3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006a7:	85 d2                	test   %edx,%edx
801006a9:	74 53                	je     801006fe <cprintf+0x9e>
      break;
    switch(c){
801006ab:	83 fa 70             	cmp    $0x70,%edx
801006ae:	74 7a                	je     8010072a <cprintf+0xca>
801006b0:	7f 6e                	jg     80100720 <cprintf+0xc0>
801006b2:	83 fa 25             	cmp    $0x25,%edx
801006b5:	0f 84 ad 00 00 00    	je     80100768 <cprintf+0x108>
801006bb:	83 fa 64             	cmp    $0x64,%edx
801006be:	0f 85 84 00 00 00    	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006cc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	8b 06                	mov    (%esi),%eax
801006d6:	e8 a5 fe ff ff       	call   80100580 <printint>
801006db:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006de:	83 c3 01             	add    $0x1,%ebx
801006e1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e5:	85 c0                	test   %eax,%eax
801006e7:	74 15                	je     801006fe <cprintf+0x9e>
    if(c != '%'){
801006e9:	83 f8 25             	cmp    $0x25,%eax
801006ec:	74 b2                	je     801006a0 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ee:	e8 fd fc ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f3:	83 c3 01             	add    $0x1,%ebx
801006f6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006fa:	85 c0                	test   %eax,%eax
801006fc:	75 eb                	jne    801006e9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100701:	85 c0                	test   %eax,%eax
80100703:	74 10                	je     80100715 <cprintf+0xb5>
    release(&cons.lock);
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 60 b5 10 80       	push   $0x8010b560
8010070d:	e8 be 43 00 00       	call   80104ad0 <release>
80100712:	83 c4 10             	add    $0x10,%esp
}
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	5b                   	pop    %ebx
80100719:	5e                   	pop    %esi
8010071a:	5f                   	pop    %edi
8010071b:	5d                   	pop    %ebp
8010071c:	c3                   	ret    
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 5b                	je     80100780 <cprintf+0x120>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010072a:	8d 46 04             	lea    0x4(%esi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	ba 10 00 00 00       	mov    $0x10,%edx
80100734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100737:	8b 06                	mov    (%esi),%eax
80100739:	e8 42 fe ff ff       	call   80100580 <printint>
8010073e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100741:	eb 9b                	jmp    801006de <cprintf+0x7e>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100750:	e8 9b fc ff ff       	call   801003f0 <consputc>
      consputc(c);
80100755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 91 fc ff ff       	call   801003f0 <consputc>
      break;
8010075f:	e9 7a ff ff ff       	jmp    801006de <cprintf+0x7e>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 7e fc ff ff       	call   801003f0 <consputc>
80100772:	e9 7c ff ff ff       	jmp    801006f3 <cprintf+0x93>
80100777:	89 f6                	mov    %esi,%esi
80100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100780:	8d 46 04             	lea    0x4(%esi),%eax
80100783:	8b 36                	mov    (%esi),%esi
80100785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100788:	b8 f8 76 10 80       	mov    $0x801076f8,%eax
8010078d:	85 f6                	test   %esi,%esi
8010078f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100792:	0f be 06             	movsbl (%esi),%eax
80100795:	84 c0                	test   %al,%al
80100797:	74 16                	je     801007af <cprintf+0x14f>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007a0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007a3:	e8 48 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007a8:	0f be 06             	movsbl (%esi),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007b2:	e9 27 ff ff ff       	jmp    801006de <cprintf+0x7e>
801007b7:	89 f6                	mov    %esi,%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 60 b5 10 80       	push   $0x8010b560
801007c8:	e8 53 42 00 00       	call   80104a20 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 ff 76 10 80       	push   $0x801076ff
801007dd:	e8 8e fb ff ff       	call   80100370 <panic>
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <InsertNewCmd>:

char temp_buf[MAX_MEMORY][INPUT_BUF];

void
InsertNewCmd()
{
801007f0:	55                   	push   %ebp
    int i = input.w % INPUT_BUF , temp_cur = history.cmd_count % 5;
801007f1:	ba 67 66 66 66       	mov    $0x66666667,%edx

char temp_buf[MAX_MEMORY][INPUT_BUF];

void
InsertNewCmd()
{
801007f6:	89 e5                	mov    %esp,%ebp
801007f8:	57                   	push   %edi
801007f9:	56                   	push   %esi
801007fa:	53                   	push   %ebx
801007fb:	83 ec 10             	sub    $0x10,%esp
    int i = input.w % INPUT_BUF , temp_cur = history.cmd_count % 5;
801007fe:	8b 0d 34 b5 10 80    	mov    0x8010b534,%ecx
80100804:	8b 1d e4 0f 11 80    	mov    0x80110fe4,%ebx
    int j = 0;
    memset(temp_buf[temp_cur] ,'\0' ,INPUT_BUF * sizeof(char));
8010080a:	68 80 00 00 00       	push   $0x80
8010080f:	6a 00                	push   $0x0
char temp_buf[MAX_MEMORY][INPUT_BUF];

void
InsertNewCmd()
{
    int i = input.w % INPUT_BUF , temp_cur = history.cmd_count % 5;
80100811:	89 c8                	mov    %ecx,%eax
80100813:	83 e3 7f             	and    $0x7f,%ebx
80100816:	f7 ea                	imul   %edx
80100818:	89 c8                	mov    %ecx,%eax
8010081a:	c1 f8 1f             	sar    $0x1f,%eax
8010081d:	89 d6                	mov    %edx,%esi
8010081f:	d1 fe                	sar    %esi
80100821:	29 c6                	sub    %eax,%esi
80100823:	8d 04 b6             	lea    (%esi,%esi,4),%eax
80100826:	89 ce                	mov    %ecx,%esi
80100828:	29 c6                	sub    %eax,%esi
    int j = 0;
    memset(temp_buf[temp_cur] ,'\0' ,INPUT_BUF * sizeof(char));
8010082a:	c1 e6 07             	shl    $0x7,%esi
8010082d:	8d be 00 10 11 80    	lea    -0x7feef000(%esi),%edi
80100833:	57                   	push   %edi
80100834:	e8 e7 42 00 00       	call   80104b20 <memset>
    while( i != ((input.e - 1)%INPUT_BUF)){
80100839:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
8010083e:	83 c4 10             	add    $0x10,%esp
80100841:	8d 48 ff             	lea    -0x1(%eax),%ecx
80100844:	31 c0                	xor    %eax,%eax
80100846:	83 e1 7f             	and    $0x7f,%ecx
80100849:	39 d9                	cmp    %ebx,%ecx
8010084b:	74 1e                	je     8010086b <InsertNewCmd+0x7b>
8010084d:	8d 76 00             	lea    0x0(%esi),%esi
                  temp_buf[temp_cur][j] = input.buf[i];
80100850:	0f b6 93 60 0f 11 80 	movzbl -0x7feef0a0(%ebx),%edx
                  j++;
                  i = (i + 1) % INPUT_BUF;
80100857:	83 c3 01             	add    $0x1,%ebx
8010085a:	83 e3 7f             	and    $0x7f,%ebx
{
    int i = input.w % INPUT_BUF , temp_cur = history.cmd_count % 5;
    int j = 0;
    memset(temp_buf[temp_cur] ,'\0' ,INPUT_BUF * sizeof(char));
    while( i != ((input.e - 1)%INPUT_BUF)){
                  temp_buf[temp_cur][j] = input.buf[i];
8010085d:	88 94 06 00 10 11 80 	mov    %dl,-0x7feef000(%esi,%eax,1)
                  j++;
80100864:	83 c0 01             	add    $0x1,%eax
InsertNewCmd()
{
    int i = input.w % INPUT_BUF , temp_cur = history.cmd_count % 5;
    int j = 0;
    memset(temp_buf[temp_cur] ,'\0' ,INPUT_BUF * sizeof(char));
    while( i != ((input.e - 1)%INPUT_BUF)){
80100867:	39 cb                	cmp    %ecx,%ebx
80100869:	75 e5                	jne    80100850 <InsertNewCmd+0x60>
8010086b:	ba 30 b5 10 80       	mov    $0x8010b530,%edx
                  temp_buf[temp_cur][j] = input.buf[i];
                  j++;
                  i = (i + 1) % INPUT_BUF;
                }
    for(int i = 4 ; i > 0 ; i--){
      history.PervCmd[i] = history.PervCmd[i-1];
80100870:	8b 4a fc             	mov    -0x4(%edx),%ecx
80100873:	83 ea 04             	sub    $0x4,%edx
80100876:	89 4a 04             	mov    %ecx,0x4(%edx)
      history.size[i] = history.size[i-1];
80100879:	8b 4a 1c             	mov    0x1c(%edx),%ecx
8010087c:	89 4a 20             	mov    %ecx,0x20(%edx)
    while( i != ((input.e - 1)%INPUT_BUF)){
                  temp_buf[temp_cur][j] = input.buf[i];
                  j++;
                  i = (i + 1) % INPUT_BUF;
                }
    for(int i = 4 ; i > 0 ; i--){
8010087f:	81 fa 20 b5 10 80    	cmp    $0x8010b520,%edx
80100885:	75 e9                	jne    80100870 <InsertNewCmd+0x80>
      history.PervCmd[i] = history.PervCmd[i-1];
      history.size[i] = history.size[i-1];
      }

    history.PervCmd[0] = temp_buf[temp_cur];
80100887:	89 3d 20 b5 10 80    	mov    %edi,0x8010b520
    history.size[0] = j;
8010088d:	a3 3c b5 10 80       	mov    %eax,0x8010b53c
}
80100892:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100895:	5b                   	pop    %ebx
80100896:	5e                   	pop    %esi
80100897:	5f                   	pop    %edi
80100898:	5d                   	pop    %ebp
80100899:	c3                   	ret    
8010089a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801008a0 <killLine>:

void
killLine()
{
  while(input.e != input.w &&
801008a0:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
801008a5:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
801008ab:	74 51                	je     801008fe <killLine+0x5e>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008ad:	83 e8 01             	sub    $0x1,%eax
801008b0:	89 c2                	mov    %eax,%edx
801008b2:	83 e2 7f             	and    $0x7f,%edx
}

void
killLine()
{
  while(input.e != input.w &&
801008b5:	80 ba 60 0f 11 80 0a 	cmpb   $0xa,-0x7feef0a0(%edx)
801008bc:	74 40                	je     801008fe <killLine+0x5e>
    history.size[0] = j;
}

void
killLine()
{
801008be:	55                   	push   %ebp
801008bf:	89 e5                	mov    %esp,%ebp
801008c1:	83 ec 08             	sub    $0x8,%esp
801008c4:	eb 1b                	jmp    801008e1 <killLine+0x41>
801008c6:	8d 76 00             	lea    0x0(%esi),%esi
801008c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008d0:	83 e8 01             	sub    $0x1,%eax
801008d3:	89 c2                	mov    %eax,%edx
801008d5:	83 e2 7f             	and    $0x7f,%edx
}

void
killLine()
{
  while(input.e != input.w &&
801008d8:	80 ba 60 0f 11 80 0a 	cmpb   $0xa,-0x7feef0a0(%edx)
801008df:	74 1c                	je     801008fd <killLine+0x5d>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801008e1:	a3 e8 0f 11 80       	mov    %eax,0x80110fe8
        consputc(BACKSPACE);
801008e6:	b8 00 01 00 00       	mov    $0x100,%eax
801008eb:	e8 00 fb ff ff       	call   801003f0 <consputc>
}

void
killLine()
{
  while(input.e != input.w &&
801008f0:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
801008f5:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
801008fb:	75 d3                	jne    801008d0 <killLine+0x30>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
}
801008fd:	c9                   	leave  
801008fe:	f3 c3                	repz ret 

80100900 <fillBuf>:

void
fillBuf()
{
80100900:	55                   	push   %ebp
80100901:	89 e5                	mov    %esp,%ebp
80100903:	56                   	push   %esi
80100904:	53                   	push   %ebx
  killLine();
80100905:	e8 96 ff ff ff       	call   801008a0 <killLine>
  for(int i = 0; i < history.size[history.cursor] ; i++)
8010090a:	8b 15 38 b5 10 80    	mov    0x8010b538,%edx
80100910:	8b 1c 95 3c b5 10 80 	mov    -0x7fef4ac4(,%edx,4),%ebx
80100917:	85 db                	test   %ebx,%ebx
80100919:	7e 31                	jle    8010094c <fillBuf+0x4c>
8010091b:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100920:	8b 34 95 20 b5 10 80 	mov    -0x7fef4ae0(,%edx,4),%esi
80100927:	01 c3                	add    %eax,%ebx
    input.buf[input.e++ % INPUT_BUF] = history.PervCmd[history.cursor][i];
80100929:	29 c6                	sub    %eax,%esi
8010092b:	90                   	nop
8010092c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100930:	8d 50 01             	lea    0x1(%eax),%edx
80100933:	89 15 e8 0f 11 80    	mov    %edx,0x80110fe8
80100939:	0f b6 0c 30          	movzbl (%eax,%esi,1),%ecx
8010093d:	83 e0 7f             	and    $0x7f,%eax

void
fillBuf()
{
  killLine();
  for(int i = 0; i < history.size[history.cursor] ; i++)
80100940:	39 da                	cmp    %ebx,%edx
    input.buf[input.e++ % INPUT_BUF] = history.PervCmd[history.cursor][i];
80100942:	88 88 60 0f 11 80    	mov    %cl,-0x7feef0a0(%eax)
80100948:	89 d0                	mov    %edx,%eax

void
fillBuf()
{
  killLine();
  for(int i = 0; i < history.size[history.cursor] ; i++)
8010094a:	75 e4                	jne    80100930 <fillBuf+0x30>
    input.buf[input.e++ % INPUT_BUF] = history.PervCmd[history.cursor][i];
}
8010094c:	5b                   	pop    %ebx
8010094d:	5e                   	pop    %esi
8010094e:	5d                   	pop    %ebp
8010094f:	c3                   	ret    

80100950 <IncCursor>:

void
IncCursor()
{
  if (history.cursor == 4)
80100950:	8b 0d 38 b5 10 80    	mov    0x8010b538,%ecx
    input.buf[input.e++ % INPUT_BUF] = history.PervCmd[history.cursor][i];
}

void
IncCursor()
{
80100956:	55                   	push   %ebp
80100957:	89 e5                	mov    %esp,%ebp
  if (history.cursor == 4)
80100959:	83 f9 04             	cmp    $0x4,%ecx
8010095c:	74 2a                	je     80100988 <IncCursor+0x38>
        return;
  history.cursor = (history.cursor + 1) % 5;
8010095e:	83 c1 01             	add    $0x1,%ecx
80100961:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100966:	89 c8                	mov    %ecx,%eax
80100968:	f7 ea                	imul   %edx
8010096a:	89 c8                	mov    %ecx,%eax
8010096c:	c1 f8 1f             	sar    $0x1f,%eax
8010096f:	d1 fa                	sar    %edx
80100971:	29 c2                	sub    %eax,%edx
80100973:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100976:	29 c1                	sub    %eax,%ecx
      if ( history.cursor == history.cmd_count) 
80100978:	3b 0d 34 b5 10 80    	cmp    0x8010b534,%ecx
void
IncCursor()
{
  if (history.cursor == 4)
        return;
  history.cursor = (history.cursor + 1) % 5;
8010097e:	89 ca                	mov    %ecx,%edx
80100980:	89 0d 38 b5 10 80    	mov    %ecx,0x8010b538
      if ( history.cursor == history.cmd_count) 
80100986:	74 08                	je     80100990 <IncCursor+0x40>
        history.cursor = history.cmd_count - 1;
}
80100988:	5d                   	pop    %ebp
80100989:	c3                   	ret    
8010098a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  if (history.cursor == 4)
        return;
  history.cursor = (history.cursor + 1) % 5;
      if ( history.cursor == history.cmd_count) 
        history.cursor = history.cmd_count - 1;
80100990:	83 ea 01             	sub    $0x1,%edx
80100993:	89 15 38 b5 10 80    	mov    %edx,0x8010b538
}
80100999:	5d                   	pop    %ebp
8010099a:	c3                   	ret    
8010099b:	90                   	nop
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009a0 <DecCursor>:

void
DecCursor()
{
  if ( history.cursor < 0)
801009a0:	a1 38 b5 10 80       	mov    0x8010b538,%eax
        history.cursor = history.cmd_count - 1;
}

void
DecCursor()
{
801009a5:	55                   	push   %ebp
801009a6:	89 e5                	mov    %esp,%ebp
  if ( history.cursor < 0)
801009a8:	85 c0                	test   %eax,%eax
801009aa:	78 08                	js     801009b4 <DecCursor+0x14>
      return;
      
  history.cursor = history.cursor - 1;
801009ac:	83 e8 01             	sub    $0x1,%eax
801009af:	a3 38 b5 10 80       	mov    %eax,0x8010b538
}
801009b4:	5d                   	pop    %ebp
801009b5:	c3                   	ret    
801009b6:	8d 76 00             	lea    0x0(%esi),%esi
801009b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009c0 <printInput>:

void
printInput()
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	53                   	push   %ebx
801009c4:	83 ec 04             	sub    $0x4,%esp
  int i = input.w % INPUT_BUF;
801009c7:	8b 1d e4 0f 11 80    	mov    0x80110fe4,%ebx
801009cd:	eb 10                	jmp    801009df <printInput+0x1f>
801009cf:	90                   	nop
  while( i != (input.e % INPUT_BUF)){ 
    consputc(input.buf[i]);
801009d0:	0f be 83 60 0f 11 80 	movsbl -0x7feef0a0(%ebx),%eax
    i = (i + 1) % INPUT_BUF;
801009d7:	83 c3 01             	add    $0x1,%ebx
void
printInput()
{
  int i = input.w % INPUT_BUF;
  while( i != (input.e % INPUT_BUF)){ 
    consputc(input.buf[i]);
801009da:	e8 11 fa ff ff       	call   801003f0 <consputc>

void
printInput()
{
  int i = input.w % INPUT_BUF;
  while( i != (input.e % INPUT_BUF)){ 
801009df:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
}

void
printInput()
{
  int i = input.w % INPUT_BUF;
801009e4:	83 e3 7f             	and    $0x7f,%ebx
  while( i != (input.e % INPUT_BUF)){ 
801009e7:	83 e0 7f             	and    $0x7f,%eax
801009ea:	39 d8                	cmp    %ebx,%eax
801009ec:	75 e2                	jne    801009d0 <printInput+0x10>
    consputc(input.buf[i]);
    i = (i + 1) % INPUT_BUF;
  }
}
801009ee:	83 c4 04             	add    $0x4,%esp
801009f1:	5b                   	pop    %ebx
801009f2:	5d                   	pop    %ebp
801009f3:	c3                   	ret    
801009f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801009fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100a00 <KeyDownPressed.part.0>:
KeyDownPressed()
{
  if ( history.cmd_count == 0) 
          return;

if (history.cursor == -1){
80100a00:	a1 38 b5 10 80       	mov    0x8010b538,%eax
80100a05:	83 f8 ff             	cmp    $0xffffffff,%eax
80100a08:	74 1e                	je     80100a28 <KeyDownPressed.part.0+0x28>
  fillBuf();
  printInput();
}

void
KeyDownPressed()
80100a0a:	55                   	push   %ebp
80100a0b:	89 e5                	mov    %esp,%ebp
80100a0d:	83 ec 08             	sub    $0x8,%esp
}

void
DecCursor()
{
  if ( history.cursor < 0)
80100a10:	85 c0                	test   %eax,%eax
80100a12:	78 08                	js     80100a1c <KeyDownPressed.part.0+0x1c>
      return;
      
  history.cursor = history.cursor - 1;
80100a14:	83 e8 01             	sub    $0x1,%eax
80100a17:	a3 38 b5 10 80       	mov    %eax,0x8010b538
  killLine();
  return;
  }

  DecCursor();
  fillBuf();
80100a1c:	e8 df fe ff ff       	call   80100900 <fillBuf>
  printInput();
}
80100a21:	c9                   	leave  
  return;
  }

  DecCursor();
  fillBuf();
  printInput();
80100a22:	eb 9c                	jmp    801009c0 <printInput>
80100a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  if ( history.cmd_count == 0) 
          return;

if (history.cursor == -1){
  killLine();
80100a28:	e9 73 fe ff ff       	jmp    801008a0 <killLine>
80100a2d:	8d 76 00             	lea    0x0(%esi),%esi

80100a30 <KeyUpPressed>:
  }
}

void
KeyUpPressed()
{
80100a30:	55                   	push   %ebp
80100a31:	89 e5                	mov    %esp,%ebp
80100a33:	53                   	push   %ebx
80100a34:	83 ec 04             	sub    $0x4,%esp
  if ( history.cmd_count == 0) 
80100a37:	8b 1d 34 b5 10 80    	mov    0x8010b534,%ebx
80100a3d:	85 db                	test   %ebx,%ebx
80100a3f:	74 3f                	je     80100a80 <KeyUpPressed+0x50>
}

void
IncCursor()
{
  if (history.cursor == 4)
80100a41:	8b 0d 38 b5 10 80    	mov    0x8010b538,%ecx
80100a47:	83 f9 04             	cmp    $0x4,%ecx
80100a4a:	74 24                	je     80100a70 <KeyUpPressed+0x40>
        return;
  history.cursor = (history.cursor + 1) % 5;
80100a4c:	83 c1 01             	add    $0x1,%ecx
80100a4f:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100a54:	89 c8                	mov    %ecx,%eax
80100a56:	f7 ea                	imul   %edx
80100a58:	89 c8                	mov    %ecx,%eax
80100a5a:	c1 f8 1f             	sar    $0x1f,%eax
80100a5d:	d1 fa                	sar    %edx
80100a5f:	29 c2                	sub    %eax,%edx
80100a61:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100a64:	29 c1                	sub    %eax,%ecx
      if ( history.cursor == history.cmd_count) 
80100a66:	39 cb                	cmp    %ecx,%ebx
80100a68:	74 26                	je     80100a90 <KeyUpPressed+0x60>
void
IncCursor()
{
  if (history.cursor == 4)
        return;
  history.cursor = (history.cursor + 1) % 5;
80100a6a:	89 0d 38 b5 10 80    	mov    %ecx,0x8010b538
{
  if ( history.cmd_count == 0) 
      return;

  IncCursor();
  fillBuf();
80100a70:	e8 8b fe ff ff       	call   80100900 <fillBuf>
  printInput();
}
80100a75:	83 c4 04             	add    $0x4,%esp
80100a78:	5b                   	pop    %ebx
80100a79:	5d                   	pop    %ebp
  if ( history.cmd_count == 0) 
      return;

  IncCursor();
  fillBuf();
  printInput();
80100a7a:	e9 41 ff ff ff       	jmp    801009c0 <printInput>
80100a7f:	90                   	nop
}
80100a80:	83 c4 04             	add    $0x4,%esp
80100a83:	5b                   	pop    %ebx
80100a84:	5d                   	pop    %ebp
80100a85:	c3                   	ret    
80100a86:	8d 76 00             	lea    0x0(%esi),%esi
80100a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if (history.cursor == 4)
        return;
  history.cursor = (history.cursor + 1) % 5;
      if ( history.cursor == history.cmd_count) 
        history.cursor = history.cmd_count - 1;
80100a90:	83 eb 01             	sub    $0x1,%ebx
80100a93:	89 1d 38 b5 10 80    	mov    %ebx,0x8010b538
{
  if ( history.cmd_count == 0) 
      return;

  IncCursor();
  fillBuf();
80100a99:	e8 62 fe ff ff       	call   80100900 <fillBuf>
  printInput();
}
80100a9e:	83 c4 04             	add    $0x4,%esp
80100aa1:	5b                   	pop    %ebx
80100aa2:	5d                   	pop    %ebp
  if ( history.cmd_count == 0) 
      return;

  IncCursor();
  fillBuf();
  printInput();
80100aa3:	e9 18 ff ff ff       	jmp    801009c0 <printInput>
80100aa8:	90                   	nop
80100aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ab0 <KeyDownPressed>:
}

void
KeyDownPressed()
{
  if ( history.cmd_count == 0) 
80100ab0:	a1 34 b5 10 80       	mov    0x8010b534,%eax
  printInput();
}

void
KeyDownPressed()
{
80100ab5:	55                   	push   %ebp
80100ab6:	89 e5                	mov    %esp,%ebp
  if ( history.cmd_count == 0) 
80100ab8:	85 c0                	test   %eax,%eax
80100aba:	74 0c                	je     80100ac8 <KeyDownPressed+0x18>
  }

  DecCursor();
  fillBuf();
  printInput();
}
80100abc:	5d                   	pop    %ebp
80100abd:	e9 3e ff ff ff       	jmp    80100a00 <KeyDownPressed.part.0>
80100ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ac8:	5d                   	pop    %ebp
80100ac9:	c3                   	ret    
80100aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ad0 <consoleintr>:

void
consoleintr(int (*getc)(void))
{
80100ad0:	55                   	push   %ebp
80100ad1:	89 e5                	mov    %esp,%ebp
80100ad3:	57                   	push   %edi
80100ad4:	56                   	push   %esi
80100ad5:	53                   	push   %ebx
  int c, doprocdump = 0;
80100ad6:	31 ff                	xor    %edi,%edi
  printInput();
}

void
consoleintr(int (*getc)(void))
{
80100ad8:	83 ec 18             	sub    $0x18,%esp
80100adb:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, doprocdump = 0;
  acquire(&cons.lock);
80100ade:	68 60 b5 10 80       	push   $0x8010b560
80100ae3:	e8 38 3f 00 00       	call   80104a20 <acquire>
  while((c = getc()) >= 0){
80100ae8:	83 c4 10             	add    $0x10,%esp
80100aeb:	90                   	nop
80100aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100af0:	ff d6                	call   *%esi
80100af2:	85 c0                	test   %eax,%eax
80100af4:	89 c3                	mov    %eax,%ebx
80100af6:	0f 88 dc 00 00 00    	js     80100bd8 <consoleintr+0x108>
    switch(c){
80100afc:	83 fb 15             	cmp    $0x15,%ebx
80100aff:	0f 84 1b 01 00 00    	je     80100c20 <consoleintr+0x150>
80100b05:	0f 8e f5 00 00 00    	jle    80100c00 <consoleintr+0x130>
80100b0b:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
80100b11:	0f 84 69 01 00 00    	je     80100c80 <consoleintr+0x1b0>
80100b17:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100b1d:	0f 84 3d 01 00 00    	je     80100c60 <consoleintr+0x190>
80100b23:	83 fb 7f             	cmp    $0x7f,%ebx
80100b26:	0f 84 04 01 00 00    	je     80100c30 <consoleintr+0x160>
    
    case (KEY_DN) :
      KeyDownPressed();
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100b2c:	85 db                	test   %ebx,%ebx
80100b2e:	74 c0                	je     80100af0 <consoleintr+0x20>
80100b30:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100b35:	89 c2                	mov    %eax,%edx
80100b37:	2b 15 e0 0f 11 80    	sub    0x80110fe0,%edx
80100b3d:	83 fa 7f             	cmp    $0x7f,%edx
80100b40:	77 ae                	ja     80100af0 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100b42:	8d 50 01             	lea    0x1(%eax),%edx
80100b45:	83 e0 7f             	and    $0x7f,%eax
    case (KEY_DN) :
      KeyDownPressed();
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100b48:	83 fb 0d             	cmp    $0xd,%ebx
        input.buf[input.e++ % INPUT_BUF] = c;
80100b4b:	89 15 e8 0f 11 80    	mov    %edx,0x80110fe8
    case (KEY_DN) :
      KeyDownPressed();
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100b51:	0f 84 49 01 00 00    	je     80100ca0 <consoleintr+0x1d0>
        input.buf[input.e++ % INPUT_BUF] = c;
80100b57:	88 98 60 0f 11 80    	mov    %bl,-0x7feef0a0(%eax)
        consputc(c);
80100b5d:	89 d8                	mov    %ebx,%eax
80100b5f:	e8 8c f8 ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100b64:	83 fb 0a             	cmp    $0xa,%ebx
80100b67:	0f 84 44 01 00 00    	je     80100cb1 <consoleintr+0x1e1>
80100b6d:	83 fb 04             	cmp    $0x4,%ebx
80100b70:	0f 84 3b 01 00 00    	je     80100cb1 <consoleintr+0x1e1>
80100b76:	a1 e0 0f 11 80       	mov    0x80110fe0,%eax
80100b7b:	83 e8 80             	sub    $0xffffff80,%eax
80100b7e:	39 05 e8 0f 11 80    	cmp    %eax,0x80110fe8
80100b84:	0f 85 66 ff ff ff    	jne    80100af0 <consoleintr+0x20>
          if ( (input.e - input.w) != 1) {
80100b8a:	89 c2                	mov    %eax,%edx
80100b8c:	2b 15 e4 0f 11 80    	sub    0x80110fe4,%edx
80100b92:	83 fa 01             	cmp    $0x1,%edx
80100b95:	74 1b                	je     80100bb2 <consoleintr+0xe2>
            InsertNewCmd();
80100b97:	e8 54 fc ff ff       	call   801007f0 <InsertNewCmd>
            history.cmd_count++;
80100b9c:	83 05 34 b5 10 80 01 	addl   $0x1,0x8010b534
80100ba3:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
            history.cursor = -1;
80100ba8:	c7 05 38 b5 10 80 ff 	movl   $0xffffffff,0x8010b538
80100baf:	ff ff ff 
          }
          input.w = input.e;
          wakeup(&input.r);
80100bb2:	83 ec 0c             	sub    $0xc,%esp
          if ( (input.e - input.w) != 1) {
            InsertNewCmd();
            history.cmd_count++;
            history.cursor = -1;
          }
          input.w = input.e;
80100bb5:	a3 e4 0f 11 80       	mov    %eax,0x80110fe4
          wakeup(&input.r);
80100bba:	68 e0 0f 11 80       	push   $0x80110fe0
80100bbf:	e8 6c 36 00 00       	call   80104230 <wakeup>
80100bc4:	83 c4 10             	add    $0x10,%esp
void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;
  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100bc7:	ff d6                	call   *%esi
80100bc9:	85 c0                	test   %eax,%eax
80100bcb:	89 c3                	mov    %eax,%ebx
80100bcd:	0f 89 29 ff ff ff    	jns    80100afc <consoleintr+0x2c>
80100bd3:	90                   	nop
80100bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 60 b5 10 80       	push   $0x8010b560
80100be0:	e8 eb 3e 00 00       	call   80104ad0 <release>
  if(doprocdump) {
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	85 ff                	test   %edi,%edi
80100bea:	0f 85 a0 00 00 00    	jne    80100c90 <consoleintr+0x1c0>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100bf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100bf3:	5b                   	pop    %ebx
80100bf4:	5e                   	pop    %esi
80100bf5:	5f                   	pop    %edi
80100bf6:	5d                   	pop    %ebp
80100bf7:	c3                   	ret    
80100bf8:	90                   	nop
80100bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100c00:	83 fb 08             	cmp    $0x8,%ebx
80100c03:	74 2b                	je     80100c30 <consoleintr+0x160>
80100c05:	83 fb 10             	cmp    $0x10,%ebx
80100c08:	0f 85 1e ff ff ff    	jne    80100b2c <consoleintr+0x5c>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100c0e:	bf 01 00 00 00       	mov    $0x1,%edi
80100c13:	e9 d8 fe ff ff       	jmp    80100af0 <consoleintr+0x20>
80100c18:	90                   	nop
80100c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    case C('U'):  // Kill line.
      killLine();
80100c20:	e8 7b fc ff ff       	call   801008a0 <killLine>
      break;
80100c25:	e9 c6 fe ff ff       	jmp    80100af0 <consoleintr+0x20>
80100c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100c30:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100c35:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
80100c3b:	0f 84 af fe ff ff    	je     80100af0 <consoleintr+0x20>
        input.e--;
80100c41:	83 e8 01             	sub    $0x1,%eax
80100c44:	a3 e8 0f 11 80       	mov    %eax,0x80110fe8
        consputc(BACKSPACE);
80100c49:	b8 00 01 00 00       	mov    $0x100,%eax
80100c4e:	e8 9d f7 ff ff       	call   801003f0 <consputc>
80100c53:	e9 98 fe ff ff       	jmp    80100af0 <consoleintr+0x20>
80100c58:	90                   	nop
80100c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

void
KeyDownPressed()
{
  if ( history.cmd_count == 0) 
80100c60:	a1 34 b5 10 80       	mov    0x8010b534,%eax
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 84 83 fe ff ff    	je     80100af0 <consoleintr+0x20>
80100c6d:	e8 8e fd ff ff       	call   80100a00 <KeyDownPressed.part.0>
80100c72:	e9 79 fe ff ff       	jmp    80100af0 <consoleintr+0x20>
80100c77:	89 f6                	mov    %esi,%esi
80100c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        consputc(BACKSPACE);
      }
      break;
    
    case (KEY_UP) :
      KeyUpPressed();
80100c80:	e8 ab fd ff ff       	call   80100a30 <KeyUpPressed>
      break;
80100c85:	e9 66 fe ff ff       	jmp    80100af0 <consoleintr+0x20>
80100c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100c90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c93:	5b                   	pop    %ebx
80100c94:	5e                   	pop    %esi
80100c95:	5f                   	pop    %edi
80100c96:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100c97:	e9 84 36 00 00       	jmp    80104320 <procdump>
80100c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      KeyDownPressed();
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
80100ca0:	c6 80 60 0f 11 80 0a 	movb   $0xa,-0x7feef0a0(%eax)
        consputc(c);
80100ca7:	b8 0a 00 00 00       	mov    $0xa,%eax
80100cac:	e8 3f f7 ff ff       	call   801003f0 <consputc>
80100cb1:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          if ( (input.e - input.w) != 1) {
80100cb6:	89 c2                	mov    %eax,%edx
80100cb8:	2b 15 e4 0f 11 80    	sub    0x80110fe4,%edx
80100cbe:	83 fa 01             	cmp    $0x1,%edx
80100cc1:	0f 85 d0 fe ff ff    	jne    80100b97 <consoleintr+0xc7>
80100cc7:	e9 e6 fe ff ff       	jmp    80100bb2 <consoleintr+0xe2>
80100ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100cd0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100cd0:	55                   	push   %ebp
80100cd1:	89 e5                	mov    %esp,%ebp
80100cd3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100cd6:	68 08 77 10 80       	push   $0x80107708
80100cdb:	68 60 b5 10 80       	push   $0x8010b560
80100ce0:	e8 db 3b 00 00       	call   801048c0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100ce5:	58                   	pop    %eax
80100ce6:	5a                   	pop    %edx
80100ce7:	6a 00                	push   $0x0
80100ce9:	6a 01                	push   $0x1
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
80100ceb:	c7 05 2c 1c 11 80 00 	movl   $0x80100600,0x80111c2c
80100cf2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100cf5:	c7 05 28 1c 11 80 70 	movl   $0x80100270,0x80111c28
80100cfc:	02 10 80 
  cons.locking = 1;
80100cff:	c7 05 94 b5 10 80 01 	movl   $0x1,0x8010b594
80100d06:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100d09:	e8 c2 18 00 00       	call   801025d0 <ioapicenable>
}
80100d0e:	83 c4 10             	add    $0x10,%esp
80100d11:	c9                   	leave  
80100d12:	c3                   	ret    
80100d13:	66 90                	xchg   %ax,%ax
80100d15:	66 90                	xchg   %ax,%ax
80100d17:	66 90                	xchg   %ax,%ax
80100d19:	66 90                	xchg   %ax,%ax
80100d1b:	66 90                	xchg   %ax,%ax
80100d1d:	66 90                	xchg   %ax,%ax
80100d1f:	90                   	nop

80100d20 <exec>:
#include "defs.h"
#include "x86.h"
#include "elf.h"

int exec(char *path, char **argv)
{
80100d20:	55                   	push   %ebp
80100d21:	89 e5                	mov    %esp,%ebp
80100d23:	57                   	push   %edi
80100d24:	56                   	push   %esi
80100d25:	53                   	push   %ebx
80100d26:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3 + MAXARG + 1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100d2c:	e8 8f 2d 00 00       	call   80103ac0 <myproc>
80100d31:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100d37:	e8 44 21 00 00       	call   80102e80 <begin_op>

  if ((ip = namei(path)) == 0)
80100d3c:	83 ec 0c             	sub    $0xc,%esp
80100d3f:	ff 75 08             	pushl  0x8(%ebp)
80100d42:	e8 a9 14 00 00       	call   801021f0 <namei>
80100d47:	83 c4 10             	add    $0x10,%esp
80100d4a:	85 c0                	test   %eax,%eax
80100d4c:	0f 84 9c 01 00 00    	je     80100eee <exec+0x1ce>
  {
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100d52:	83 ec 0c             	sub    $0xc,%esp
80100d55:	89 c3                	mov    %eax,%ebx
80100d57:	50                   	push   %eax
80100d58:	e8 43 0c 00 00       	call   801019a0 <ilock>
  pgdir = 0;

  // Check ELF header
  if (readi(ip, (char *)&elf, 0, sizeof(elf)) != sizeof(elf))
80100d5d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100d63:	6a 34                	push   $0x34
80100d65:	6a 00                	push   $0x0
80100d67:	50                   	push   %eax
80100d68:	53                   	push   %ebx
80100d69:	e8 12 0f 00 00       	call   80101c80 <readi>
80100d6e:	83 c4 20             	add    $0x20,%esp
80100d71:	83 f8 34             	cmp    $0x34,%eax
80100d74:	74 22                	je     80100d98 <exec+0x78>
bad:
  if (pgdir)
    freevm(pgdir);
  if (ip)
  {
    iunlockput(ip);
80100d76:	83 ec 0c             	sub    $0xc,%esp
80100d79:	53                   	push   %ebx
80100d7a:	e8 b1 0e 00 00       	call   80101c30 <iunlockput>
    end_op();
80100d7f:	e8 6c 21 00 00       	call   80102ef0 <end_op>
80100d84:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100d87:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100d8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100d8f:	5b                   	pop    %ebx
80100d90:	5e                   	pop    %esi
80100d91:	5f                   	pop    %edi
80100d92:	5d                   	pop    %ebp
80100d93:	c3                   	ret    
80100d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if (readi(ip, (char *)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if (elf.magic != ELF_MAGIC)
80100d98:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100d9f:	45 4c 46 
80100da2:	75 d2                	jne    80100d76 <exec+0x56>
    goto bad;

  if ((pgdir = setupkvm()) == 0)
80100da4:	e8 37 66 00 00       	call   801073e0 <setupkvm>
80100da9:	85 c0                	test   %eax,%eax
80100dab:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100db1:	74 c3                	je     80100d76 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph))
80100db3:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100dba:	00 
80100dbb:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100dc1:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100dc8:	00 00 00 
80100dcb:	0f 84 c5 00 00 00    	je     80100e96 <exec+0x176>
80100dd1:	31 ff                	xor    %edi,%edi
80100dd3:	eb 18                	jmp    80100ded <exec+0xcd>
80100dd5:	8d 76 00             	lea    0x0(%esi),%esi
80100dd8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100ddf:	83 c7 01             	add    $0x1,%edi
80100de2:	83 c6 20             	add    $0x20,%esi
80100de5:	39 f8                	cmp    %edi,%eax
80100de7:	0f 8e a9 00 00 00    	jle    80100e96 <exec+0x176>
  {
    if (readi(ip, (char *)&ph, off, sizeof(ph)) != sizeof(ph))
80100ded:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100df3:	6a 20                	push   $0x20
80100df5:	56                   	push   %esi
80100df6:	50                   	push   %eax
80100df7:	53                   	push   %ebx
80100df8:	e8 83 0e 00 00       	call   80101c80 <readi>
80100dfd:	83 c4 10             	add    $0x10,%esp
80100e00:	83 f8 20             	cmp    $0x20,%eax
80100e03:	75 7b                	jne    80100e80 <exec+0x160>
      goto bad;
    if (ph.type != ELF_PROG_LOAD)
80100e05:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100e0c:	75 ca                	jne    80100dd8 <exec+0xb8>
      continue;
    if (ph.memsz < ph.filesz)
80100e0e:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100e14:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100e1a:	72 64                	jb     80100e80 <exec+0x160>
      goto bad;
    if (ph.vaddr + ph.memsz < ph.vaddr)
80100e1c:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100e22:	72 5c                	jb     80100e80 <exec+0x160>
      goto bad;
    if ((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100e24:	83 ec 04             	sub    $0x4,%esp
80100e27:	50                   	push   %eax
80100e28:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100e2e:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100e34:	e8 f7 63 00 00       	call   80107230 <allocuvm>
80100e39:	83 c4 10             	add    $0x10,%esp
80100e3c:	85 c0                	test   %eax,%eax
80100e3e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100e44:	74 3a                	je     80100e80 <exec+0x160>
      goto bad;
    if (ph.vaddr % PGSIZE != 0)
80100e46:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100e4c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100e51:	75 2d                	jne    80100e80 <exec+0x160>
      goto bad;
    if (loaduvm(pgdir, (char *)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100e53:	83 ec 0c             	sub    $0xc,%esp
80100e56:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100e5c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100e62:	53                   	push   %ebx
80100e63:	50                   	push   %eax
80100e64:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100e6a:	e8 01 63 00 00       	call   80107170 <loaduvm>
80100e6f:	83 c4 20             	add    $0x20,%esp
80100e72:	85 c0                	test   %eax,%eax
80100e74:	0f 89 5e ff ff ff    	jns    80100dd8 <exec+0xb8>
80100e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

bad:
  if (pgdir)
    freevm(pgdir);
80100e80:	83 ec 0c             	sub    $0xc,%esp
80100e83:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100e89:	e8 d2 64 00 00       	call   80107360 <freevm>
80100e8e:	83 c4 10             	add    $0x10,%esp
80100e91:	e9 e0 fe ff ff       	jmp    80100d76 <exec+0x56>
    if (ph.vaddr % PGSIZE != 0)
      goto bad;
    if (loaduvm(pgdir, (char *)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100e96:	83 ec 0c             	sub    $0xc,%esp
80100e99:	53                   	push   %ebx
80100e9a:	e8 91 0d 00 00       	call   80101c30 <iunlockput>
  end_op();
80100e9f:	e8 4c 20 00 00       	call   80102ef0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100ea4:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if ((sz = allocuvm(pgdir, sz, sz + 2 * PGSIZE)) == 0)
80100eaa:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100ead:	05 ff 0f 00 00       	add    $0xfff,%eax
80100eb2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if ((sz = allocuvm(pgdir, sz, sz + 2 * PGSIZE)) == 0)
80100eb7:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100ebd:	52                   	push   %edx
80100ebe:	50                   	push   %eax
80100ebf:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100ec5:	e8 66 63 00 00       	call   80107230 <allocuvm>
80100eca:	83 c4 10             	add    $0x10,%esp
80100ecd:	85 c0                	test   %eax,%eax
80100ecf:	89 c6                	mov    %eax,%esi
80100ed1:	75 3a                	jne    80100f0d <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

bad:
  if (pgdir)
    freevm(pgdir);
80100ed3:	83 ec 0c             	sub    $0xc,%esp
80100ed6:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100edc:	e8 7f 64 00 00       	call   80107360 <freevm>
80100ee1:	83 c4 10             	add    $0x10,%esp
  if (ip)
  {
    iunlockput(ip);
    end_op();
  }
  return -1;
80100ee4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ee9:	e9 9e fe ff ff       	jmp    80100d8c <exec+0x6c>

  begin_op();

  if ((ip = namei(path)) == 0)
  {
    end_op();
80100eee:	e8 fd 1f 00 00       	call   80102ef0 <end_op>
    cprintf("exec: fail\n");
80100ef3:	83 ec 0c             	sub    $0xc,%esp
80100ef6:	68 21 77 10 80       	push   $0x80107721
80100efb:	e8 60 f7 ff ff       	call   80100660 <cprintf>
    return -1;
80100f00:	83 c4 10             	add    $0x10,%esp
80100f03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f08:	e9 7f fe ff ff       	jmp    80100d8c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if ((sz = allocuvm(pgdir, sz, sz + 2 * PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char *)(sz - 2 * PGSIZE));
80100f0d:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100f13:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for (argc = 0; argv[argc]; argc++)
80100f16:	31 ff                	xor    %edi,%edi
80100f18:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if ((sz = allocuvm(pgdir, sz, sz + 2 * PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char *)(sz - 2 * PGSIZE));
80100f1a:	50                   	push   %eax
80100f1b:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100f21:	e8 5a 65 00 00       	call   80107480 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for (argc = 0; argv[argc]; argc++)
80100f26:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f29:	83 c4 10             	add    $0x10,%esp
80100f2c:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100f32:	8b 00                	mov    (%eax),%eax
80100f34:	85 c0                	test   %eax,%eax
80100f36:	74 79                	je     80100fb1 <exec+0x291>
80100f38:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100f3e:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100f44:	eb 13                	jmp    80100f59 <exec+0x239>
80100f46:	8d 76 00             	lea    0x0(%esi),%esi
80100f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  {
    if (argc >= MAXARG)
80100f50:	83 ff 20             	cmp    $0x20,%edi
80100f53:	0f 84 7a ff ff ff    	je     80100ed3 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100f59:	83 ec 0c             	sub    $0xc,%esp
80100f5c:	50                   	push   %eax
80100f5d:	e8 fe 3d 00 00       	call   80104d60 <strlen>
80100f62:	f7 d0                	not    %eax
80100f64:	01 c3                	add    %eax,%ebx
    if (copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100f66:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f69:	5a                   	pop    %edx
  // Push argument strings, prepare rest of stack in ustack.
  for (argc = 0; argv[argc]; argc++)
  {
    if (argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100f6a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if (copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100f6d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100f70:	e8 eb 3d 00 00       	call   80104d60 <strlen>
80100f75:	83 c0 01             	add    $0x1,%eax
80100f78:	50                   	push   %eax
80100f79:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f7c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100f7f:	53                   	push   %ebx
80100f80:	56                   	push   %esi
80100f81:	e8 6a 66 00 00       	call   801075f0 <copyout>
80100f86:	83 c4 20             	add    $0x20,%esp
80100f89:	85 c0                	test   %eax,%eax
80100f8b:	0f 88 42 ff ff ff    	js     80100ed3 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char *)(sz - 2 * PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for (argc = 0; argv[argc]; argc++)
80100f91:	8b 45 0c             	mov    0xc(%ebp),%eax
    if (argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if (copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3 + argc] = sp;
80100f94:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char *)(sz - 2 * PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for (argc = 0; argv[argc]; argc++)
80100f9b:	83 c7 01             	add    $0x1,%edi
    if (argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if (copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3 + argc] = sp;
80100f9e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char *)(sz - 2 * PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for (argc = 0; argv[argc]; argc++)
80100fa4:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100fa7:	85 c0                	test   %eax,%eax
80100fa9:	75 a5                	jne    80100f50 <exec+0x230>
80100fab:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3 + argc] = 0;

  ustack[0] = 0xffffffff; // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc + 1) * 4; // argv pointer
80100fb1:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100fb8:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if (copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3 + argc] = sp;
  }
  ustack[3 + argc] = 0;
80100fba:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100fc1:	00 00 00 00 

  ustack[0] = 0xffffffff; // fake return PC
80100fc5:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100fcc:	ff ff ff 
  ustack[1] = argc;
80100fcf:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc + 1) * 4; // argv pointer
80100fd5:	29 c1                	sub    %eax,%ecx

  sp -= (3 + argc + 1) * 4;
80100fd7:	83 c0 0c             	add    $0xc,%eax
80100fda:	29 c3                	sub    %eax,%ebx
  if (copyout(pgdir, sp, ustack, (3 + argc + 1) * 4) < 0)
80100fdc:	50                   	push   %eax
80100fdd:	52                   	push   %edx
80100fde:	53                   	push   %ebx
80100fdf:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3 + argc] = 0;

  ustack[0] = 0xffffffff; // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc + 1) * 4; // argv pointer
80100fe5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3 + argc + 1) * 4;
  if (copyout(pgdir, sp, ustack, (3 + argc + 1) * 4) < 0)
80100feb:	e8 00 66 00 00       	call   801075f0 <copyout>
80100ff0:	83 c4 10             	add    $0x10,%esp
80100ff3:	85 c0                	test   %eax,%eax
80100ff5:	0f 88 d8 fe ff ff    	js     80100ed3 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for (last = s = path; *s; s++)
80100ffb:	8b 45 08             	mov    0x8(%ebp),%eax
80100ffe:	0f b6 10             	movzbl (%eax),%edx
80101001:	84 d2                	test   %dl,%dl
80101003:	74 19                	je     8010101e <exec+0x2fe>
80101005:	8b 4d 08             	mov    0x8(%ebp),%ecx
80101008:	83 c0 01             	add    $0x1,%eax
    if (*s == '/')
      last = s + 1;
8010100b:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3 + argc + 1) * 4;
  if (copyout(pgdir, sp, ustack, (3 + argc + 1) * 4) < 0)
    goto bad;

  // Save program name for debugging.
  for (last = s = path; *s; s++)
8010100e:	0f b6 10             	movzbl (%eax),%edx
    if (*s == '/')
      last = s + 1;
80101011:	0f 44 c8             	cmove  %eax,%ecx
80101014:	83 c0 01             	add    $0x1,%eax
  sp -= (3 + argc + 1) * 4;
  if (copyout(pgdir, sp, ustack, (3 + argc + 1) * 4) < 0)
    goto bad;

  // Save program name for debugging.
  for (last = s = path; *s; s++)
80101017:	84 d2                	test   %dl,%dl
80101019:	75 f0                	jne    8010100b <exec+0x2eb>
8010101b:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if (*s == '/')
      last = s + 1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010101e:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101024:	50                   	push   %eax
80101025:	6a 10                	push   $0x10
80101027:	ff 75 08             	pushl  0x8(%ebp)
8010102a:	89 f8                	mov    %edi,%eax
8010102c:	83 c0 6c             	add    $0x6c,%eax
8010102f:	50                   	push   %eax
80101030:	e8 eb 3c 00 00       	call   80104d20 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80101035:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if (*s == '/')
      last = s + 1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
8010103b:	89 f8                	mov    %edi,%eax
8010103d:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80101040:	89 30                	mov    %esi,(%eax)
      last = s + 1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80101042:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry; // main
80101045:	89 c1                	mov    %eax,%ecx
80101047:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010104d:	8b 40 18             	mov    0x18(%eax),%eax
80101050:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101053:	8b 41 18             	mov    0x18(%ecx),%eax
80101056:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101059:	89 0c 24             	mov    %ecx,(%esp)
8010105c:	e8 7f 5f 00 00       	call   80106fe0 <switchuvm>
  freevm(oldpgdir);
80101061:	89 3c 24             	mov    %edi,(%esp)
80101064:	e8 f7 62 00 00       	call   80107360 <freevm>
  return 0;
80101069:	83 c4 10             	add    $0x10,%esp
8010106c:	31 c0                	xor    %eax,%eax
8010106e:	e9 19 fd ff ff       	jmp    80100d8c <exec+0x6c>
80101073:	66 90                	xchg   %ax,%ax
80101075:	66 90                	xchg   %ax,%ax
80101077:	66 90                	xchg   %ax,%ax
80101079:	66 90                	xchg   %ax,%ax
8010107b:	66 90                	xchg   %ax,%ax
8010107d:	66 90                	xchg   %ax,%ax
8010107f:	90                   	nop

80101080 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101080:	55                   	push   %ebp
80101081:	89 e5                	mov    %esp,%ebp
80101083:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101086:	68 2d 77 10 80       	push   $0x8010772d
8010108b:	68 80 12 11 80       	push   $0x80111280
80101090:	e8 2b 38 00 00       	call   801048c0 <initlock>
}
80101095:	83 c4 10             	add    $0x10,%esp
80101098:	c9                   	leave  
80101099:	c3                   	ret    
8010109a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801010a0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801010a0:	55                   	push   %ebp
801010a1:	89 e5                	mov    %esp,%ebp
801010a3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801010a4:	bb b4 12 11 80       	mov    $0x801112b4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
801010a9:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
801010ac:	68 80 12 11 80       	push   $0x80111280
801010b1:	e8 6a 39 00 00       	call   80104a20 <acquire>
801010b6:	83 c4 10             	add    $0x10,%esp
801010b9:	eb 10                	jmp    801010cb <filealloc+0x2b>
801010bb:	90                   	nop
801010bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801010c0:	83 c3 18             	add    $0x18,%ebx
801010c3:	81 fb 14 1c 11 80    	cmp    $0x80111c14,%ebx
801010c9:	74 25                	je     801010f0 <filealloc+0x50>
    if(f->ref == 0){
801010cb:	8b 43 04             	mov    0x4(%ebx),%eax
801010ce:	85 c0                	test   %eax,%eax
801010d0:	75 ee                	jne    801010c0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
801010d2:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
801010d5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
801010dc:	68 80 12 11 80       	push   $0x80111280
801010e1:	e8 ea 39 00 00       	call   80104ad0 <release>
      return f;
801010e6:	89 d8                	mov    %ebx,%eax
801010e8:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
801010eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801010ee:	c9                   	leave  
801010ef:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
801010f0:	83 ec 0c             	sub    $0xc,%esp
801010f3:	68 80 12 11 80       	push   $0x80111280
801010f8:	e8 d3 39 00 00       	call   80104ad0 <release>
  return 0;
801010fd:	83 c4 10             	add    $0x10,%esp
80101100:	31 c0                	xor    %eax,%eax
}
80101102:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101105:	c9                   	leave  
80101106:	c3                   	ret    
80101107:	89 f6                	mov    %esi,%esi
80101109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101110 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	53                   	push   %ebx
80101114:	83 ec 10             	sub    $0x10,%esp
80101117:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010111a:	68 80 12 11 80       	push   $0x80111280
8010111f:	e8 fc 38 00 00       	call   80104a20 <acquire>
  if(f->ref < 1)
80101124:	8b 43 04             	mov    0x4(%ebx),%eax
80101127:	83 c4 10             	add    $0x10,%esp
8010112a:	85 c0                	test   %eax,%eax
8010112c:	7e 1a                	jle    80101148 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010112e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101131:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80101134:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101137:	68 80 12 11 80       	push   $0x80111280
8010113c:	e8 8f 39 00 00       	call   80104ad0 <release>
  return f;
}
80101141:	89 d8                	mov    %ebx,%eax
80101143:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101146:	c9                   	leave  
80101147:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80101148:	83 ec 0c             	sub    $0xc,%esp
8010114b:	68 34 77 10 80       	push   $0x80107734
80101150:	e8 1b f2 ff ff       	call   80100370 <panic>
80101155:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101160 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101160:	55                   	push   %ebp
80101161:	89 e5                	mov    %esp,%ebp
80101163:	57                   	push   %edi
80101164:	56                   	push   %esi
80101165:	53                   	push   %ebx
80101166:	83 ec 28             	sub    $0x28,%esp
80101169:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
8010116c:	68 80 12 11 80       	push   $0x80111280
80101171:	e8 aa 38 00 00       	call   80104a20 <acquire>
  if(f->ref < 1)
80101176:	8b 47 04             	mov    0x4(%edi),%eax
80101179:	83 c4 10             	add    $0x10,%esp
8010117c:	85 c0                	test   %eax,%eax
8010117e:	0f 8e 9b 00 00 00    	jle    8010121f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80101184:	83 e8 01             	sub    $0x1,%eax
80101187:	85 c0                	test   %eax,%eax
80101189:	89 47 04             	mov    %eax,0x4(%edi)
8010118c:	74 1a                	je     801011a8 <fileclose+0x48>
    release(&ftable.lock);
8010118e:	c7 45 08 80 12 11 80 	movl   $0x80111280,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101195:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101198:	5b                   	pop    %ebx
80101199:	5e                   	pop    %esi
8010119a:	5f                   	pop    %edi
8010119b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
8010119c:	e9 2f 39 00 00       	jmp    80104ad0 <release>
801011a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
801011a8:	0f b6 47 09          	movzbl 0x9(%edi),%eax
801011ac:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801011ae:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
801011b1:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
801011b4:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
801011ba:	88 45 e7             	mov    %al,-0x19(%ebp)
801011bd:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801011c0:	68 80 12 11 80       	push   $0x80111280
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
801011c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801011c8:	e8 03 39 00 00       	call   80104ad0 <release>

  if(ff.type == FD_PIPE)
801011cd:	83 c4 10             	add    $0x10,%esp
801011d0:	83 fb 01             	cmp    $0x1,%ebx
801011d3:	74 13                	je     801011e8 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
801011d5:	83 fb 02             	cmp    $0x2,%ebx
801011d8:	74 26                	je     80101200 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801011da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011dd:	5b                   	pop    %ebx
801011de:	5e                   	pop    %esi
801011df:	5f                   	pop    %edi
801011e0:	5d                   	pop    %ebp
801011e1:	c3                   	ret    
801011e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
801011e8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801011ec:	83 ec 08             	sub    $0x8,%esp
801011ef:	53                   	push   %ebx
801011f0:	56                   	push   %esi
801011f1:	e8 2a 24 00 00       	call   80103620 <pipeclose>
801011f6:	83 c4 10             	add    $0x10,%esp
801011f9:	eb df                	jmp    801011da <fileclose+0x7a>
801011fb:	90                   	nop
801011fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80101200:	e8 7b 1c 00 00       	call   80102e80 <begin_op>
    iput(ff.ip);
80101205:	83 ec 0c             	sub    $0xc,%esp
80101208:	ff 75 e0             	pushl  -0x20(%ebp)
8010120b:	e8 c0 08 00 00       	call   80101ad0 <iput>
    end_op();
80101210:	83 c4 10             	add    $0x10,%esp
  }
}
80101213:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101216:	5b                   	pop    %ebx
80101217:	5e                   	pop    %esi
80101218:	5f                   	pop    %edi
80101219:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
8010121a:	e9 d1 1c 00 00       	jmp    80102ef0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
8010121f:	83 ec 0c             	sub    $0xc,%esp
80101222:	68 3c 77 10 80       	push   $0x8010773c
80101227:	e8 44 f1 ff ff       	call   80100370 <panic>
8010122c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101230 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101230:	55                   	push   %ebp
80101231:	89 e5                	mov    %esp,%ebp
80101233:	53                   	push   %ebx
80101234:	83 ec 04             	sub    $0x4,%esp
80101237:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010123a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010123d:	75 31                	jne    80101270 <filestat+0x40>
    ilock(f->ip);
8010123f:	83 ec 0c             	sub    $0xc,%esp
80101242:	ff 73 10             	pushl  0x10(%ebx)
80101245:	e8 56 07 00 00       	call   801019a0 <ilock>
    stati(f->ip, st);
8010124a:	58                   	pop    %eax
8010124b:	5a                   	pop    %edx
8010124c:	ff 75 0c             	pushl  0xc(%ebp)
8010124f:	ff 73 10             	pushl  0x10(%ebx)
80101252:	e8 f9 09 00 00       	call   80101c50 <stati>
    iunlock(f->ip);
80101257:	59                   	pop    %ecx
80101258:	ff 73 10             	pushl  0x10(%ebx)
8010125b:	e8 20 08 00 00       	call   80101a80 <iunlock>
    return 0;
80101260:	83 c4 10             	add    $0x10,%esp
80101263:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101265:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101268:	c9                   	leave  
80101269:	c3                   	ret    
8010126a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80101270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101275:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101278:	c9                   	leave  
80101279:	c3                   	ret    
8010127a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101280 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101280:	55                   	push   %ebp
80101281:	89 e5                	mov    %esp,%ebp
80101283:	57                   	push   %edi
80101284:	56                   	push   %esi
80101285:	53                   	push   %ebx
80101286:	83 ec 0c             	sub    $0xc,%esp
80101289:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010128c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010128f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101292:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101296:	74 60                	je     801012f8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101298:	8b 03                	mov    (%ebx),%eax
8010129a:	83 f8 01             	cmp    $0x1,%eax
8010129d:	74 41                	je     801012e0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010129f:	83 f8 02             	cmp    $0x2,%eax
801012a2:	75 5b                	jne    801012ff <fileread+0x7f>
    ilock(f->ip);
801012a4:	83 ec 0c             	sub    $0xc,%esp
801012a7:	ff 73 10             	pushl  0x10(%ebx)
801012aa:	e8 f1 06 00 00       	call   801019a0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801012af:	57                   	push   %edi
801012b0:	ff 73 14             	pushl  0x14(%ebx)
801012b3:	56                   	push   %esi
801012b4:	ff 73 10             	pushl  0x10(%ebx)
801012b7:	e8 c4 09 00 00       	call   80101c80 <readi>
801012bc:	83 c4 20             	add    $0x20,%esp
801012bf:	85 c0                	test   %eax,%eax
801012c1:	89 c6                	mov    %eax,%esi
801012c3:	7e 03                	jle    801012c8 <fileread+0x48>
      f->off += r;
801012c5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801012c8:	83 ec 0c             	sub    $0xc,%esp
801012cb:	ff 73 10             	pushl  0x10(%ebx)
801012ce:	e8 ad 07 00 00       	call   80101a80 <iunlock>
    return r;
801012d3:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801012d6:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
801012d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012db:	5b                   	pop    %ebx
801012dc:	5e                   	pop    %esi
801012dd:	5f                   	pop    %edi
801012de:	5d                   	pop    %ebp
801012df:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
801012e0:	8b 43 0c             	mov    0xc(%ebx),%eax
801012e3:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
801012e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012e9:	5b                   	pop    %ebx
801012ea:	5e                   	pop    %esi
801012eb:	5f                   	pop    %edi
801012ec:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
801012ed:	e9 ce 24 00 00       	jmp    801037c0 <piperead>
801012f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
801012f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012fd:	eb d9                	jmp    801012d8 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
801012ff:	83 ec 0c             	sub    $0xc,%esp
80101302:	68 46 77 10 80       	push   $0x80107746
80101307:	e8 64 f0 ff ff       	call   80100370 <panic>
8010130c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101310 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101310:	55                   	push   %ebp
80101311:	89 e5                	mov    %esp,%ebp
80101313:	57                   	push   %edi
80101314:	56                   	push   %esi
80101315:	53                   	push   %ebx
80101316:	83 ec 1c             	sub    $0x1c,%esp
80101319:	8b 75 08             	mov    0x8(%ebp),%esi
8010131c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010131f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101323:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101326:	8b 45 10             	mov    0x10(%ebp),%eax
80101329:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
8010132c:	0f 84 aa 00 00 00    	je     801013dc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101332:	8b 06                	mov    (%esi),%eax
80101334:	83 f8 01             	cmp    $0x1,%eax
80101337:	0f 84 c2 00 00 00    	je     801013ff <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010133d:	83 f8 02             	cmp    $0x2,%eax
80101340:	0f 85 d8 00 00 00    	jne    8010141e <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101346:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101349:	31 ff                	xor    %edi,%edi
8010134b:	85 c0                	test   %eax,%eax
8010134d:	7f 34                	jg     80101383 <filewrite+0x73>
8010134f:	e9 9c 00 00 00       	jmp    801013f0 <filewrite+0xe0>
80101354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101358:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010135b:	83 ec 0c             	sub    $0xc,%esp
8010135e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101361:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101364:	e8 17 07 00 00       	call   80101a80 <iunlock>
      end_op();
80101369:	e8 82 1b 00 00       	call   80102ef0 <end_op>
8010136e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101371:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101374:	39 d8                	cmp    %ebx,%eax
80101376:	0f 85 95 00 00 00    	jne    80101411 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010137c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010137e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101381:	7e 6d                	jle    801013f0 <filewrite+0xe0>
      int n1 = n - i;
80101383:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101386:	b8 00 06 00 00       	mov    $0x600,%eax
8010138b:	29 fb                	sub    %edi,%ebx
8010138d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101393:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101396:	e8 e5 1a 00 00       	call   80102e80 <begin_op>
      ilock(f->ip);
8010139b:	83 ec 0c             	sub    $0xc,%esp
8010139e:	ff 76 10             	pushl  0x10(%esi)
801013a1:	e8 fa 05 00 00       	call   801019a0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801013a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801013a9:	53                   	push   %ebx
801013aa:	ff 76 14             	pushl  0x14(%esi)
801013ad:	01 f8                	add    %edi,%eax
801013af:	50                   	push   %eax
801013b0:	ff 76 10             	pushl  0x10(%esi)
801013b3:	e8 c8 09 00 00       	call   80101d80 <writei>
801013b8:	83 c4 20             	add    $0x20,%esp
801013bb:	85 c0                	test   %eax,%eax
801013bd:	7f 99                	jg     80101358 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
801013bf:	83 ec 0c             	sub    $0xc,%esp
801013c2:	ff 76 10             	pushl  0x10(%esi)
801013c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801013c8:	e8 b3 06 00 00       	call   80101a80 <iunlock>
      end_op();
801013cd:	e8 1e 1b 00 00       	call   80102ef0 <end_op>

      if(r < 0)
801013d2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801013d5:	83 c4 10             	add    $0x10,%esp
801013d8:	85 c0                	test   %eax,%eax
801013da:	74 98                	je     80101374 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801013dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801013df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801013e4:	5b                   	pop    %ebx
801013e5:	5e                   	pop    %esi
801013e6:	5f                   	pop    %edi
801013e7:	5d                   	pop    %ebp
801013e8:	c3                   	ret    
801013e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801013f0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801013f3:	75 e7                	jne    801013dc <filewrite+0xcc>
  }
  panic("filewrite");
}
801013f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013f8:	89 f8                	mov    %edi,%eax
801013fa:	5b                   	pop    %ebx
801013fb:	5e                   	pop    %esi
801013fc:	5f                   	pop    %edi
801013fd:	5d                   	pop    %ebp
801013fe:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801013ff:	8b 46 0c             	mov    0xc(%esi),%eax
80101402:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101405:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101408:	5b                   	pop    %ebx
80101409:	5e                   	pop    %esi
8010140a:	5f                   	pop    %edi
8010140b:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010140c:	e9 af 22 00 00       	jmp    801036c0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80101411:	83 ec 0c             	sub    $0xc,%esp
80101414:	68 4f 77 10 80       	push   $0x8010774f
80101419:	e8 52 ef ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
8010141e:	83 ec 0c             	sub    $0xc,%esp
80101421:	68 55 77 10 80       	push   $0x80107755
80101426:	e8 45 ef ff ff       	call   80100370 <panic>
8010142b:	66 90                	xchg   %ax,%ax
8010142d:	66 90                	xchg   %ax,%ax
8010142f:	90                   	nop

80101430 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101430:	55                   	push   %ebp
80101431:	89 e5                	mov    %esp,%ebp
80101433:	57                   	push   %edi
80101434:	56                   	push   %esi
80101435:	53                   	push   %ebx
80101436:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101439:	8b 0d 80 1c 11 80    	mov    0x80111c80,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010143f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101442:	85 c9                	test   %ecx,%ecx
80101444:	0f 84 85 00 00 00    	je     801014cf <balloc+0x9f>
8010144a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101451:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101454:	83 ec 08             	sub    $0x8,%esp
80101457:	89 f0                	mov    %esi,%eax
80101459:	c1 f8 0c             	sar    $0xc,%eax
8010145c:	03 05 98 1c 11 80    	add    0x80111c98,%eax
80101462:	50                   	push   %eax
80101463:	ff 75 d8             	pushl  -0x28(%ebp)
80101466:	e8 65 ec ff ff       	call   801000d0 <bread>
8010146b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010146e:	a1 80 1c 11 80       	mov    0x80111c80,%eax
80101473:	83 c4 10             	add    $0x10,%esp
80101476:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101479:	31 c0                	xor    %eax,%eax
8010147b:	eb 2d                	jmp    801014aa <balloc+0x7a>
8010147d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101480:	89 c1                	mov    %eax,%ecx
80101482:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101487:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010148a:	83 e1 07             	and    $0x7,%ecx
8010148d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010148f:	89 c1                	mov    %eax,%ecx
80101491:	c1 f9 03             	sar    $0x3,%ecx
80101494:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101499:	85 d7                	test   %edx,%edi
8010149b:	74 43                	je     801014e0 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010149d:	83 c0 01             	add    $0x1,%eax
801014a0:	83 c6 01             	add    $0x1,%esi
801014a3:	3d 00 10 00 00       	cmp    $0x1000,%eax
801014a8:	74 05                	je     801014af <balloc+0x7f>
801014aa:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801014ad:	72 d1                	jb     80101480 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801014af:	83 ec 0c             	sub    $0xc,%esp
801014b2:	ff 75 e4             	pushl  -0x1c(%ebp)
801014b5:	e8 26 ed ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801014ba:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801014c1:	83 c4 10             	add    $0x10,%esp
801014c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801014c7:	39 05 80 1c 11 80    	cmp    %eax,0x80111c80
801014cd:	77 82                	ja     80101451 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801014cf:	83 ec 0c             	sub    $0xc,%esp
801014d2:	68 5f 77 10 80       	push   $0x8010775f
801014d7:	e8 94 ee ff ff       	call   80100370 <panic>
801014dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801014e0:	09 fa                	or     %edi,%edx
801014e2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801014e5:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801014e8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801014ec:	57                   	push   %edi
801014ed:	e8 6e 1b 00 00       	call   80103060 <log_write>
        brelse(bp);
801014f2:	89 3c 24             	mov    %edi,(%esp)
801014f5:	e8 e6 ec ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801014fa:	58                   	pop    %eax
801014fb:	5a                   	pop    %edx
801014fc:	56                   	push   %esi
801014fd:	ff 75 d8             	pushl  -0x28(%ebp)
80101500:	e8 cb eb ff ff       	call   801000d0 <bread>
80101505:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101507:	8d 40 5c             	lea    0x5c(%eax),%eax
8010150a:	83 c4 0c             	add    $0xc,%esp
8010150d:	68 00 02 00 00       	push   $0x200
80101512:	6a 00                	push   $0x0
80101514:	50                   	push   %eax
80101515:	e8 06 36 00 00       	call   80104b20 <memset>
  log_write(bp);
8010151a:	89 1c 24             	mov    %ebx,(%esp)
8010151d:	e8 3e 1b 00 00       	call   80103060 <log_write>
  brelse(bp);
80101522:	89 1c 24             	mov    %ebx,(%esp)
80101525:	e8 b6 ec ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
8010152a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010152d:	89 f0                	mov    %esi,%eax
8010152f:	5b                   	pop    %ebx
80101530:	5e                   	pop    %esi
80101531:	5f                   	pop    %edi
80101532:	5d                   	pop    %ebp
80101533:	c3                   	ret    
80101534:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010153a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101540 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101540:	55                   	push   %ebp
80101541:	89 e5                	mov    %esp,%ebp
80101543:	57                   	push   %edi
80101544:	56                   	push   %esi
80101545:	53                   	push   %ebx
80101546:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101548:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010154a:	bb d4 1c 11 80       	mov    $0x80111cd4,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010154f:	83 ec 28             	sub    $0x28,%esp
80101552:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101555:	68 a0 1c 11 80       	push   $0x80111ca0
8010155a:	e8 c1 34 00 00       	call   80104a20 <acquire>
8010155f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101562:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101565:	eb 1b                	jmp    80101582 <iget+0x42>
80101567:	89 f6                	mov    %esi,%esi
80101569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101570:	85 f6                	test   %esi,%esi
80101572:	74 44                	je     801015b8 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101574:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010157a:	81 fb f4 38 11 80    	cmp    $0x801138f4,%ebx
80101580:	74 4e                	je     801015d0 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101582:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101585:	85 c9                	test   %ecx,%ecx
80101587:	7e e7                	jle    80101570 <iget+0x30>
80101589:	39 3b                	cmp    %edi,(%ebx)
8010158b:	75 e3                	jne    80101570 <iget+0x30>
8010158d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101590:	75 de                	jne    80101570 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101592:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101595:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101598:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010159a:	68 a0 1c 11 80       	push   $0x80111ca0

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010159f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801015a2:	e8 29 35 00 00       	call   80104ad0 <release>
      return ip;
801015a7:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
801015aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015ad:	89 f0                	mov    %esi,%eax
801015af:	5b                   	pop    %ebx
801015b0:	5e                   	pop    %esi
801015b1:	5f                   	pop    %edi
801015b2:	5d                   	pop    %ebp
801015b3:	c3                   	ret    
801015b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801015b8:	85 c9                	test   %ecx,%ecx
801015ba:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801015bd:	81 c3 90 00 00 00    	add    $0x90,%ebx
801015c3:	81 fb f4 38 11 80    	cmp    $0x801138f4,%ebx
801015c9:	75 b7                	jne    80101582 <iget+0x42>
801015cb:	90                   	nop
801015cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801015d0:	85 f6                	test   %esi,%esi
801015d2:	74 2d                	je     80101601 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801015d4:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801015d7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801015d9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801015dc:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801015e3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801015ea:	68 a0 1c 11 80       	push   $0x80111ca0
801015ef:	e8 dc 34 00 00       	call   80104ad0 <release>

  return ip;
801015f4:	83 c4 10             	add    $0x10,%esp
}
801015f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015fa:	89 f0                	mov    %esi,%eax
801015fc:	5b                   	pop    %ebx
801015fd:	5e                   	pop    %esi
801015fe:	5f                   	pop    %edi
801015ff:	5d                   	pop    %ebp
80101600:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
80101601:	83 ec 0c             	sub    $0xc,%esp
80101604:	68 75 77 10 80       	push   $0x80107775
80101609:	e8 62 ed ff ff       	call   80100370 <panic>
8010160e:	66 90                	xchg   %ax,%ax

80101610 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	57                   	push   %edi
80101614:	56                   	push   %esi
80101615:	53                   	push   %ebx
80101616:	89 c6                	mov    %eax,%esi
80101618:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010161b:	83 fa 0b             	cmp    $0xb,%edx
8010161e:	77 18                	ja     80101638 <bmap+0x28>
80101620:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
80101623:	8b 43 5c             	mov    0x5c(%ebx),%eax
80101626:	85 c0                	test   %eax,%eax
80101628:	74 76                	je     801016a0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010162a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010162d:	5b                   	pop    %ebx
8010162e:	5e                   	pop    %esi
8010162f:	5f                   	pop    %edi
80101630:	5d                   	pop    %ebp
80101631:	c3                   	ret    
80101632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101638:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
8010163b:	83 fb 7f             	cmp    $0x7f,%ebx
8010163e:	0f 87 83 00 00 00    	ja     801016c7 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101644:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010164a:	85 c0                	test   %eax,%eax
8010164c:	74 6a                	je     801016b8 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010164e:	83 ec 08             	sub    $0x8,%esp
80101651:	50                   	push   %eax
80101652:	ff 36                	pushl  (%esi)
80101654:	e8 77 ea ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101659:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010165d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101660:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101662:	8b 1a                	mov    (%edx),%ebx
80101664:	85 db                	test   %ebx,%ebx
80101666:	75 1d                	jne    80101685 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101668:	8b 06                	mov    (%esi),%eax
8010166a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010166d:	e8 be fd ff ff       	call   80101430 <balloc>
80101672:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101675:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101678:	89 c3                	mov    %eax,%ebx
8010167a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010167c:	57                   	push   %edi
8010167d:	e8 de 19 00 00       	call   80103060 <log_write>
80101682:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101685:	83 ec 0c             	sub    $0xc,%esp
80101688:	57                   	push   %edi
80101689:	e8 52 eb ff ff       	call   801001e0 <brelse>
8010168e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101691:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101694:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101696:	5b                   	pop    %ebx
80101697:	5e                   	pop    %esi
80101698:	5f                   	pop    %edi
80101699:	5d                   	pop    %ebp
8010169a:	c3                   	ret    
8010169b:	90                   	nop
8010169c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
801016a0:	8b 06                	mov    (%esi),%eax
801016a2:	e8 89 fd ff ff       	call   80101430 <balloc>
801016a7:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801016aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016ad:	5b                   	pop    %ebx
801016ae:	5e                   	pop    %esi
801016af:	5f                   	pop    %edi
801016b0:	5d                   	pop    %ebp
801016b1:	c3                   	ret    
801016b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801016b8:	8b 06                	mov    (%esi),%eax
801016ba:	e8 71 fd ff ff       	call   80101430 <balloc>
801016bf:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801016c5:	eb 87                	jmp    8010164e <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
801016c7:	83 ec 0c             	sub    $0xc,%esp
801016ca:	68 85 77 10 80       	push   $0x80107785
801016cf:	e8 9c ec ff ff       	call   80100370 <panic>
801016d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801016da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801016e0 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	56                   	push   %esi
801016e4:	53                   	push   %ebx
801016e5:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
801016e8:	83 ec 08             	sub    $0x8,%esp
801016eb:	6a 01                	push   $0x1
801016ed:	ff 75 08             	pushl  0x8(%ebp)
801016f0:	e8 db e9 ff ff       	call   801000d0 <bread>
801016f5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801016f7:	8d 40 5c             	lea    0x5c(%eax),%eax
801016fa:	83 c4 0c             	add    $0xc,%esp
801016fd:	6a 1c                	push   $0x1c
801016ff:	50                   	push   %eax
80101700:	56                   	push   %esi
80101701:	e8 ca 34 00 00       	call   80104bd0 <memmove>
  brelse(bp);
80101706:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101709:	83 c4 10             	add    $0x10,%esp
}
8010170c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010170f:	5b                   	pop    %ebx
80101710:	5e                   	pop    %esi
80101711:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
80101712:	e9 c9 ea ff ff       	jmp    801001e0 <brelse>
80101717:	89 f6                	mov    %esi,%esi
80101719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101720 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101720:	55                   	push   %ebp
80101721:	89 e5                	mov    %esp,%ebp
80101723:	56                   	push   %esi
80101724:	53                   	push   %ebx
80101725:	89 d3                	mov    %edx,%ebx
80101727:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
80101729:	83 ec 08             	sub    $0x8,%esp
8010172c:	68 80 1c 11 80       	push   $0x80111c80
80101731:	50                   	push   %eax
80101732:	e8 a9 ff ff ff       	call   801016e0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101737:	58                   	pop    %eax
80101738:	5a                   	pop    %edx
80101739:	89 da                	mov    %ebx,%edx
8010173b:	c1 ea 0c             	shr    $0xc,%edx
8010173e:	03 15 98 1c 11 80    	add    0x80111c98,%edx
80101744:	52                   	push   %edx
80101745:	56                   	push   %esi
80101746:	e8 85 e9 ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010174b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010174d:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101753:	ba 01 00 00 00       	mov    $0x1,%edx
80101758:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010175b:	c1 fb 03             	sar    $0x3,%ebx
8010175e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101761:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101763:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101768:	85 d1                	test   %edx,%ecx
8010176a:	74 27                	je     80101793 <bfree+0x73>
8010176c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010176e:	f7 d2                	not    %edx
80101770:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101772:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101775:	21 d0                	and    %edx,%eax
80101777:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010177b:	56                   	push   %esi
8010177c:	e8 df 18 00 00       	call   80103060 <log_write>
  brelse(bp);
80101781:	89 34 24             	mov    %esi,(%esp)
80101784:	e8 57 ea ff ff       	call   801001e0 <brelse>
}
80101789:	83 c4 10             	add    $0x10,%esp
8010178c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010178f:	5b                   	pop    %ebx
80101790:	5e                   	pop    %esi
80101791:	5d                   	pop    %ebp
80101792:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101793:	83 ec 0c             	sub    $0xc,%esp
80101796:	68 98 77 10 80       	push   $0x80107798
8010179b:	e8 d0 eb ff ff       	call   80100370 <panic>

801017a0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	53                   	push   %ebx
801017a4:	bb e0 1c 11 80       	mov    $0x80111ce0,%ebx
801017a9:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
801017ac:	68 ab 77 10 80       	push   $0x801077ab
801017b1:	68 a0 1c 11 80       	push   $0x80111ca0
801017b6:	e8 05 31 00 00       	call   801048c0 <initlock>
801017bb:	83 c4 10             	add    $0x10,%esp
801017be:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
801017c0:	83 ec 08             	sub    $0x8,%esp
801017c3:	68 b2 77 10 80       	push   $0x801077b2
801017c8:	53                   	push   %ebx
801017c9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801017cf:	e8 bc 2f 00 00       	call   80104790 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801017d4:	83 c4 10             	add    $0x10,%esp
801017d7:	81 fb 00 39 11 80    	cmp    $0x80113900,%ebx
801017dd:	75 e1                	jne    801017c0 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
801017df:	83 ec 08             	sub    $0x8,%esp
801017e2:	68 80 1c 11 80       	push   $0x80111c80
801017e7:	ff 75 08             	pushl  0x8(%ebp)
801017ea:	e8 f1 fe ff ff       	call   801016e0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801017ef:	ff 35 98 1c 11 80    	pushl  0x80111c98
801017f5:	ff 35 94 1c 11 80    	pushl  0x80111c94
801017fb:	ff 35 90 1c 11 80    	pushl  0x80111c90
80101801:	ff 35 8c 1c 11 80    	pushl  0x80111c8c
80101807:	ff 35 88 1c 11 80    	pushl  0x80111c88
8010180d:	ff 35 84 1c 11 80    	pushl  0x80111c84
80101813:	ff 35 80 1c 11 80    	pushl  0x80111c80
80101819:	68 18 78 10 80       	push   $0x80107818
8010181e:	e8 3d ee ff ff       	call   80100660 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101823:	83 c4 30             	add    $0x30,%esp
80101826:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101829:	c9                   	leave  
8010182a:	c3                   	ret    
8010182b:	90                   	nop
8010182c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101830 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101830:	55                   	push   %ebp
80101831:	89 e5                	mov    %esp,%ebp
80101833:	57                   	push   %edi
80101834:	56                   	push   %esi
80101835:	53                   	push   %ebx
80101836:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101839:	83 3d 88 1c 11 80 01 	cmpl   $0x1,0x80111c88
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101840:	8b 45 0c             	mov    0xc(%ebp),%eax
80101843:	8b 75 08             	mov    0x8(%ebp),%esi
80101846:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101849:	0f 86 91 00 00 00    	jbe    801018e0 <ialloc+0xb0>
8010184f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101854:	eb 21                	jmp    80101877 <ialloc+0x47>
80101856:	8d 76 00             	lea    0x0(%esi),%esi
80101859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101860:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101863:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101866:	57                   	push   %edi
80101867:	e8 74 e9 ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010186c:	83 c4 10             	add    $0x10,%esp
8010186f:	39 1d 88 1c 11 80    	cmp    %ebx,0x80111c88
80101875:	76 69                	jbe    801018e0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101877:	89 d8                	mov    %ebx,%eax
80101879:	83 ec 08             	sub    $0x8,%esp
8010187c:	c1 e8 03             	shr    $0x3,%eax
8010187f:	03 05 94 1c 11 80    	add    0x80111c94,%eax
80101885:	50                   	push   %eax
80101886:	56                   	push   %esi
80101887:	e8 44 e8 ff ff       	call   801000d0 <bread>
8010188c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010188e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101890:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101893:	83 e0 07             	and    $0x7,%eax
80101896:	c1 e0 06             	shl    $0x6,%eax
80101899:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010189d:	66 83 39 00          	cmpw   $0x0,(%ecx)
801018a1:	75 bd                	jne    80101860 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801018a3:	83 ec 04             	sub    $0x4,%esp
801018a6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801018a9:	6a 40                	push   $0x40
801018ab:	6a 00                	push   $0x0
801018ad:	51                   	push   %ecx
801018ae:	e8 6d 32 00 00       	call   80104b20 <memset>
      dip->type = type;
801018b3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801018b7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801018ba:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801018bd:	89 3c 24             	mov    %edi,(%esp)
801018c0:	e8 9b 17 00 00       	call   80103060 <log_write>
      brelse(bp);
801018c5:	89 3c 24             	mov    %edi,(%esp)
801018c8:	e8 13 e9 ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801018cd:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801018d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801018d3:	89 da                	mov    %ebx,%edx
801018d5:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801018d7:	5b                   	pop    %ebx
801018d8:	5e                   	pop    %esi
801018d9:	5f                   	pop    %edi
801018da:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801018db:	e9 60 fc ff ff       	jmp    80101540 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801018e0:	83 ec 0c             	sub    $0xc,%esp
801018e3:	68 b8 77 10 80       	push   $0x801077b8
801018e8:	e8 83 ea ff ff       	call   80100370 <panic>
801018ed:	8d 76 00             	lea    0x0(%esi),%esi

801018f0 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
801018f0:	55                   	push   %ebp
801018f1:	89 e5                	mov    %esp,%ebp
801018f3:	56                   	push   %esi
801018f4:	53                   	push   %ebx
801018f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018f8:	83 ec 08             	sub    $0x8,%esp
801018fb:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801018fe:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101901:	c1 e8 03             	shr    $0x3,%eax
80101904:	03 05 94 1c 11 80    	add    0x80111c94,%eax
8010190a:	50                   	push   %eax
8010190b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010190e:	e8 bd e7 ff ff       	call   801000d0 <bread>
80101913:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101915:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101918:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010191c:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010191f:	83 e0 07             	and    $0x7,%eax
80101922:	c1 e0 06             	shl    $0x6,%eax
80101925:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101929:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010192c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101930:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
80101933:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101937:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010193b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010193f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101943:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101947:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010194a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010194d:	6a 34                	push   $0x34
8010194f:	53                   	push   %ebx
80101950:	50                   	push   %eax
80101951:	e8 7a 32 00 00       	call   80104bd0 <memmove>
  log_write(bp);
80101956:	89 34 24             	mov    %esi,(%esp)
80101959:	e8 02 17 00 00       	call   80103060 <log_write>
  brelse(bp);
8010195e:	89 75 08             	mov    %esi,0x8(%ebp)
80101961:	83 c4 10             	add    $0x10,%esp
}
80101964:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101967:	5b                   	pop    %ebx
80101968:	5e                   	pop    %esi
80101969:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010196a:	e9 71 e8 ff ff       	jmp    801001e0 <brelse>
8010196f:	90                   	nop

80101970 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	53                   	push   %ebx
80101974:	83 ec 10             	sub    $0x10,%esp
80101977:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010197a:	68 a0 1c 11 80       	push   $0x80111ca0
8010197f:	e8 9c 30 00 00       	call   80104a20 <acquire>
  ip->ref++;
80101984:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101988:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
8010198f:	e8 3c 31 00 00       	call   80104ad0 <release>
  return ip;
}
80101994:	89 d8                	mov    %ebx,%eax
80101996:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101999:	c9                   	leave  
8010199a:	c3                   	ret    
8010199b:	90                   	nop
8010199c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019a0 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	56                   	push   %esi
801019a4:	53                   	push   %ebx
801019a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801019a8:	85 db                	test   %ebx,%ebx
801019aa:	0f 84 b7 00 00 00    	je     80101a67 <ilock+0xc7>
801019b0:	8b 53 08             	mov    0x8(%ebx),%edx
801019b3:	85 d2                	test   %edx,%edx
801019b5:	0f 8e ac 00 00 00    	jle    80101a67 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
801019bb:	8d 43 0c             	lea    0xc(%ebx),%eax
801019be:	83 ec 0c             	sub    $0xc,%esp
801019c1:	50                   	push   %eax
801019c2:	e8 09 2e 00 00       	call   801047d0 <acquiresleep>

  if(ip->valid == 0){
801019c7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801019ca:	83 c4 10             	add    $0x10,%esp
801019cd:	85 c0                	test   %eax,%eax
801019cf:	74 0f                	je     801019e0 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801019d1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019d4:	5b                   	pop    %ebx
801019d5:	5e                   	pop    %esi
801019d6:	5d                   	pop    %ebp
801019d7:	c3                   	ret    
801019d8:	90                   	nop
801019d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019e0:	8b 43 04             	mov    0x4(%ebx),%eax
801019e3:	83 ec 08             	sub    $0x8,%esp
801019e6:	c1 e8 03             	shr    $0x3,%eax
801019e9:	03 05 94 1c 11 80    	add    0x80111c94,%eax
801019ef:	50                   	push   %eax
801019f0:	ff 33                	pushl  (%ebx)
801019f2:	e8 d9 e6 ff ff       	call   801000d0 <bread>
801019f7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801019f9:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801019fc:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801019ff:	83 e0 07             	and    $0x7,%eax
80101a02:	c1 e0 06             	shl    $0x6,%eax
80101a05:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101a09:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a0c:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
80101a0f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101a13:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101a17:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101a1b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101a1f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101a23:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101a27:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101a2b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101a2e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a31:	6a 34                	push   $0x34
80101a33:	50                   	push   %eax
80101a34:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101a37:	50                   	push   %eax
80101a38:	e8 93 31 00 00       	call   80104bd0 <memmove>
    brelse(bp);
80101a3d:	89 34 24             	mov    %esi,(%esp)
80101a40:	e8 9b e7 ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101a45:	83 c4 10             	add    $0x10,%esp
80101a48:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
80101a4d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101a54:	0f 85 77 ff ff ff    	jne    801019d1 <ilock+0x31>
      panic("ilock: no type");
80101a5a:	83 ec 0c             	sub    $0xc,%esp
80101a5d:	68 d0 77 10 80       	push   $0x801077d0
80101a62:	e8 09 e9 ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101a67:	83 ec 0c             	sub    $0xc,%esp
80101a6a:	68 ca 77 10 80       	push   $0x801077ca
80101a6f:	e8 fc e8 ff ff       	call   80100370 <panic>
80101a74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101a7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101a80 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101a80:	55                   	push   %ebp
80101a81:	89 e5                	mov    %esp,%ebp
80101a83:	56                   	push   %esi
80101a84:	53                   	push   %ebx
80101a85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a88:	85 db                	test   %ebx,%ebx
80101a8a:	74 28                	je     80101ab4 <iunlock+0x34>
80101a8c:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a8f:	83 ec 0c             	sub    $0xc,%esp
80101a92:	56                   	push   %esi
80101a93:	e8 d8 2d 00 00       	call   80104870 <holdingsleep>
80101a98:	83 c4 10             	add    $0x10,%esp
80101a9b:	85 c0                	test   %eax,%eax
80101a9d:	74 15                	je     80101ab4 <iunlock+0x34>
80101a9f:	8b 43 08             	mov    0x8(%ebx),%eax
80101aa2:	85 c0                	test   %eax,%eax
80101aa4:	7e 0e                	jle    80101ab4 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101aa6:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101aa9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101aac:	5b                   	pop    %ebx
80101aad:	5e                   	pop    %esi
80101aae:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
80101aaf:	e9 7c 2d 00 00       	jmp    80104830 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101ab4:	83 ec 0c             	sub    $0xc,%esp
80101ab7:	68 df 77 10 80       	push   $0x801077df
80101abc:	e8 af e8 ff ff       	call   80100370 <panic>
80101ac1:	eb 0d                	jmp    80101ad0 <iput>
80101ac3:	90                   	nop
80101ac4:	90                   	nop
80101ac5:	90                   	nop
80101ac6:	90                   	nop
80101ac7:	90                   	nop
80101ac8:	90                   	nop
80101ac9:	90                   	nop
80101aca:	90                   	nop
80101acb:	90                   	nop
80101acc:	90                   	nop
80101acd:	90                   	nop
80101ace:	90                   	nop
80101acf:	90                   	nop

80101ad0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	57                   	push   %edi
80101ad4:	56                   	push   %esi
80101ad5:	53                   	push   %ebx
80101ad6:	83 ec 28             	sub    $0x28,%esp
80101ad9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
80101adc:	8d 7e 0c             	lea    0xc(%esi),%edi
80101adf:	57                   	push   %edi
80101ae0:	e8 eb 2c 00 00       	call   801047d0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101ae5:	8b 56 4c             	mov    0x4c(%esi),%edx
80101ae8:	83 c4 10             	add    $0x10,%esp
80101aeb:	85 d2                	test   %edx,%edx
80101aed:	74 07                	je     80101af6 <iput+0x26>
80101aef:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80101af4:	74 32                	je     80101b28 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
80101af6:	83 ec 0c             	sub    $0xc,%esp
80101af9:	57                   	push   %edi
80101afa:	e8 31 2d 00 00       	call   80104830 <releasesleep>

  acquire(&icache.lock);
80101aff:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80101b06:	e8 15 2f 00 00       	call   80104a20 <acquire>
  ip->ref--;
80101b0b:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
80101b0f:	83 c4 10             	add    $0x10,%esp
80101b12:	c7 45 08 a0 1c 11 80 	movl   $0x80111ca0,0x8(%ebp)
}
80101b19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b1c:	5b                   	pop    %ebx
80101b1d:	5e                   	pop    %esi
80101b1e:	5f                   	pop    %edi
80101b1f:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
80101b20:	e9 ab 2f 00 00       	jmp    80104ad0 <release>
80101b25:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
80101b28:	83 ec 0c             	sub    $0xc,%esp
80101b2b:	68 a0 1c 11 80       	push   $0x80111ca0
80101b30:	e8 eb 2e 00 00       	call   80104a20 <acquire>
    int r = ip->ref;
80101b35:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
80101b38:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80101b3f:	e8 8c 2f 00 00       	call   80104ad0 <release>
    if(r == 1){
80101b44:	83 c4 10             	add    $0x10,%esp
80101b47:	83 fb 01             	cmp    $0x1,%ebx
80101b4a:	75 aa                	jne    80101af6 <iput+0x26>
80101b4c:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80101b52:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101b55:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101b58:	89 cf                	mov    %ecx,%edi
80101b5a:	eb 0b                	jmp    80101b67 <iput+0x97>
80101b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b60:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101b63:	39 fb                	cmp    %edi,%ebx
80101b65:	74 19                	je     80101b80 <iput+0xb0>
    if(ip->addrs[i]){
80101b67:	8b 13                	mov    (%ebx),%edx
80101b69:	85 d2                	test   %edx,%edx
80101b6b:	74 f3                	je     80101b60 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101b6d:	8b 06                	mov    (%esi),%eax
80101b6f:	e8 ac fb ff ff       	call   80101720 <bfree>
      ip->addrs[i] = 0;
80101b74:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80101b7a:	eb e4                	jmp    80101b60 <iput+0x90>
80101b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101b80:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101b86:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101b89:	85 c0                	test   %eax,%eax
80101b8b:	75 33                	jne    80101bc0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101b8d:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101b90:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101b97:	56                   	push   %esi
80101b98:	e8 53 fd ff ff       	call   801018f0 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
80101b9d:	31 c0                	xor    %eax,%eax
80101b9f:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101ba3:	89 34 24             	mov    %esi,(%esp)
80101ba6:	e8 45 fd ff ff       	call   801018f0 <iupdate>
      ip->valid = 0;
80101bab:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101bb2:	83 c4 10             	add    $0x10,%esp
80101bb5:	e9 3c ff ff ff       	jmp    80101af6 <iput+0x26>
80101bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101bc0:	83 ec 08             	sub    $0x8,%esp
80101bc3:	50                   	push   %eax
80101bc4:	ff 36                	pushl  (%esi)
80101bc6:	e8 05 e5 ff ff       	call   801000d0 <bread>
80101bcb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101bd1:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101bd4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101bd7:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101bda:	83 c4 10             	add    $0x10,%esp
80101bdd:	89 cf                	mov    %ecx,%edi
80101bdf:	eb 0e                	jmp    80101bef <iput+0x11f>
80101be1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101be8:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
80101beb:	39 fb                	cmp    %edi,%ebx
80101bed:	74 0f                	je     80101bfe <iput+0x12e>
      if(a[j])
80101bef:	8b 13                	mov    (%ebx),%edx
80101bf1:	85 d2                	test   %edx,%edx
80101bf3:	74 f3                	je     80101be8 <iput+0x118>
        bfree(ip->dev, a[j]);
80101bf5:	8b 06                	mov    (%esi),%eax
80101bf7:	e8 24 fb ff ff       	call   80101720 <bfree>
80101bfc:	eb ea                	jmp    80101be8 <iput+0x118>
    }
    brelse(bp);
80101bfe:	83 ec 0c             	sub    $0xc,%esp
80101c01:	ff 75 e4             	pushl  -0x1c(%ebp)
80101c04:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101c07:	e8 d4 e5 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101c0c:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101c12:	8b 06                	mov    (%esi),%eax
80101c14:	e8 07 fb ff ff       	call   80101720 <bfree>
    ip->addrs[NDIRECT] = 0;
80101c19:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101c20:	00 00 00 
80101c23:	83 c4 10             	add    $0x10,%esp
80101c26:	e9 62 ff ff ff       	jmp    80101b8d <iput+0xbd>
80101c2b:	90                   	nop
80101c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c30 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101c30:	55                   	push   %ebp
80101c31:	89 e5                	mov    %esp,%ebp
80101c33:	53                   	push   %ebx
80101c34:	83 ec 10             	sub    $0x10,%esp
80101c37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101c3a:	53                   	push   %ebx
80101c3b:	e8 40 fe ff ff       	call   80101a80 <iunlock>
  iput(ip);
80101c40:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101c43:	83 c4 10             	add    $0x10,%esp
}
80101c46:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c49:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101c4a:	e9 81 fe ff ff       	jmp    80101ad0 <iput>
80101c4f:	90                   	nop

80101c50 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	8b 55 08             	mov    0x8(%ebp),%edx
80101c56:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101c59:	8b 0a                	mov    (%edx),%ecx
80101c5b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101c5e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101c61:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101c64:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101c68:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101c6b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101c6f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101c73:	8b 52 58             	mov    0x58(%edx),%edx
80101c76:	89 50 10             	mov    %edx,0x10(%eax)
}
80101c79:	5d                   	pop    %ebp
80101c7a:	c3                   	ret    
80101c7b:	90                   	nop
80101c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c80 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	57                   	push   %edi
80101c84:	56                   	push   %esi
80101c85:	53                   	push   %ebx
80101c86:	83 ec 1c             	sub    $0x1c,%esp
80101c89:	8b 45 08             	mov    0x8(%ebp),%eax
80101c8c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101c8f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c92:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101c97:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101c9a:	8b 7d 14             	mov    0x14(%ebp),%edi
80101c9d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ca0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ca3:	0f 84 a7 00 00 00    	je     80101d50 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ca9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101cac:	8b 40 58             	mov    0x58(%eax),%eax
80101caf:	39 f0                	cmp    %esi,%eax
80101cb1:	0f 82 c1 00 00 00    	jb     80101d78 <readi+0xf8>
80101cb7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101cba:	89 fa                	mov    %edi,%edx
80101cbc:	01 f2                	add    %esi,%edx
80101cbe:	0f 82 b4 00 00 00    	jb     80101d78 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101cc4:	89 c1                	mov    %eax,%ecx
80101cc6:	29 f1                	sub    %esi,%ecx
80101cc8:	39 d0                	cmp    %edx,%eax
80101cca:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ccd:	31 ff                	xor    %edi,%edi
80101ccf:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101cd1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101cd4:	74 6d                	je     80101d43 <readi+0xc3>
80101cd6:	8d 76 00             	lea    0x0(%esi),%esi
80101cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ce0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101ce3:	89 f2                	mov    %esi,%edx
80101ce5:	c1 ea 09             	shr    $0x9,%edx
80101ce8:	89 d8                	mov    %ebx,%eax
80101cea:	e8 21 f9 ff ff       	call   80101610 <bmap>
80101cef:	83 ec 08             	sub    $0x8,%esp
80101cf2:	50                   	push   %eax
80101cf3:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80101cf5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101cfa:	e8 d1 e3 ff ff       	call   801000d0 <bread>
80101cff:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101d01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d04:	89 f1                	mov    %esi,%ecx
80101d06:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101d0c:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
80101d0f:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101d12:	29 cb                	sub    %ecx,%ebx
80101d14:	29 f8                	sub    %edi,%eax
80101d16:	39 c3                	cmp    %eax,%ebx
80101d18:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101d1b:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
80101d1f:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d20:	01 df                	add    %ebx,%edi
80101d22:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101d24:	50                   	push   %eax
80101d25:	ff 75 e0             	pushl  -0x20(%ebp)
80101d28:	e8 a3 2e 00 00       	call   80104bd0 <memmove>
    brelse(bp);
80101d2d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d30:	89 14 24             	mov    %edx,(%esp)
80101d33:	e8 a8 e4 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d38:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101d3b:	83 c4 10             	add    $0x10,%esp
80101d3e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101d41:	77 9d                	ja     80101ce0 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101d43:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101d46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d49:	5b                   	pop    %ebx
80101d4a:	5e                   	pop    %esi
80101d4b:	5f                   	pop    %edi
80101d4c:	5d                   	pop    %ebp
80101d4d:	c3                   	ret    
80101d4e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101d50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101d54:	66 83 f8 09          	cmp    $0x9,%ax
80101d58:	77 1e                	ja     80101d78 <readi+0xf8>
80101d5a:	8b 04 c5 20 1c 11 80 	mov    -0x7feee3e0(,%eax,8),%eax
80101d61:	85 c0                	test   %eax,%eax
80101d63:	74 13                	je     80101d78 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101d65:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101d68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d6b:	5b                   	pop    %ebx
80101d6c:	5e                   	pop    %esi
80101d6d:	5f                   	pop    %edi
80101d6e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101d6f:	ff e0                	jmp    *%eax
80101d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101d78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d7d:	eb c7                	jmp    80101d46 <readi+0xc6>
80101d7f:	90                   	nop

80101d80 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101d80:	55                   	push   %ebp
80101d81:	89 e5                	mov    %esp,%ebp
80101d83:	57                   	push   %edi
80101d84:	56                   	push   %esi
80101d85:	53                   	push   %ebx
80101d86:	83 ec 1c             	sub    $0x1c,%esp
80101d89:	8b 45 08             	mov    0x8(%ebp),%eax
80101d8c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101d8f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101d92:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101d97:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101d9a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101d9d:	8b 75 10             	mov    0x10(%ebp),%esi
80101da0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101da3:	0f 84 b7 00 00 00    	je     80101e60 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101da9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101dac:	39 70 58             	cmp    %esi,0x58(%eax)
80101daf:	0f 82 eb 00 00 00    	jb     80101ea0 <writei+0x120>
80101db5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101db8:	89 f8                	mov    %edi,%eax
80101dba:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101dbc:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101dc1:	0f 87 d9 00 00 00    	ja     80101ea0 <writei+0x120>
80101dc7:	39 c6                	cmp    %eax,%esi
80101dc9:	0f 87 d1 00 00 00    	ja     80101ea0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101dcf:	85 ff                	test   %edi,%edi
80101dd1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101dd8:	74 78                	je     80101e52 <writei+0xd2>
80101dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101de0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101de3:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101de5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101dea:	c1 ea 09             	shr    $0x9,%edx
80101ded:	89 f8                	mov    %edi,%eax
80101def:	e8 1c f8 ff ff       	call   80101610 <bmap>
80101df4:	83 ec 08             	sub    $0x8,%esp
80101df7:	50                   	push   %eax
80101df8:	ff 37                	pushl  (%edi)
80101dfa:	e8 d1 e2 ff ff       	call   801000d0 <bread>
80101dff:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101e01:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e04:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101e07:	89 f1                	mov    %esi,%ecx
80101e09:	83 c4 0c             	add    $0xc,%esp
80101e0c:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101e12:	29 cb                	sub    %ecx,%ebx
80101e14:	39 c3                	cmp    %eax,%ebx
80101e16:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101e19:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101e1d:	53                   	push   %ebx
80101e1e:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e21:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101e23:	50                   	push   %eax
80101e24:	e8 a7 2d 00 00       	call   80104bd0 <memmove>
    log_write(bp);
80101e29:	89 3c 24             	mov    %edi,(%esp)
80101e2c:	e8 2f 12 00 00       	call   80103060 <log_write>
    brelse(bp);
80101e31:	89 3c 24             	mov    %edi,(%esp)
80101e34:	e8 a7 e3 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e39:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101e3c:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101e3f:	83 c4 10             	add    $0x10,%esp
80101e42:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101e45:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101e48:	77 96                	ja     80101de0 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101e4a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101e4d:	3b 70 58             	cmp    0x58(%eax),%esi
80101e50:	77 36                	ja     80101e88 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101e52:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101e55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e58:	5b                   	pop    %ebx
80101e59:	5e                   	pop    %esi
80101e5a:	5f                   	pop    %edi
80101e5b:	5d                   	pop    %ebp
80101e5c:	c3                   	ret    
80101e5d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101e60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101e64:	66 83 f8 09          	cmp    $0x9,%ax
80101e68:	77 36                	ja     80101ea0 <writei+0x120>
80101e6a:	8b 04 c5 24 1c 11 80 	mov    -0x7feee3dc(,%eax,8),%eax
80101e71:	85 c0                	test   %eax,%eax
80101e73:	74 2b                	je     80101ea0 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101e75:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101e78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e7b:	5b                   	pop    %ebx
80101e7c:	5e                   	pop    %esi
80101e7d:	5f                   	pop    %edi
80101e7e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101e7f:	ff e0                	jmp    *%eax
80101e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101e88:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101e8b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101e8e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101e91:	50                   	push   %eax
80101e92:	e8 59 fa ff ff       	call   801018f0 <iupdate>
80101e97:	83 c4 10             	add    $0x10,%esp
80101e9a:	eb b6                	jmp    80101e52 <writei+0xd2>
80101e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101ea0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ea5:	eb ae                	jmp    80101e55 <writei+0xd5>
80101ea7:	89 f6                	mov    %esi,%esi
80101ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101eb0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101eb0:	55                   	push   %ebp
80101eb1:	89 e5                	mov    %esp,%ebp
80101eb3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101eb6:	6a 0e                	push   $0xe
80101eb8:	ff 75 0c             	pushl  0xc(%ebp)
80101ebb:	ff 75 08             	pushl  0x8(%ebp)
80101ebe:	e8 8d 2d 00 00       	call   80104c50 <strncmp>
}
80101ec3:	c9                   	leave  
80101ec4:	c3                   	ret    
80101ec5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ed0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ed0:	55                   	push   %ebp
80101ed1:	89 e5                	mov    %esp,%ebp
80101ed3:	57                   	push   %edi
80101ed4:	56                   	push   %esi
80101ed5:	53                   	push   %ebx
80101ed6:	83 ec 1c             	sub    $0x1c,%esp
80101ed9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101edc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101ee1:	0f 85 80 00 00 00    	jne    80101f67 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101ee7:	8b 53 58             	mov    0x58(%ebx),%edx
80101eea:	31 ff                	xor    %edi,%edi
80101eec:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101eef:	85 d2                	test   %edx,%edx
80101ef1:	75 0d                	jne    80101f00 <dirlookup+0x30>
80101ef3:	eb 5b                	jmp    80101f50 <dirlookup+0x80>
80101ef5:	8d 76 00             	lea    0x0(%esi),%esi
80101ef8:	83 c7 10             	add    $0x10,%edi
80101efb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101efe:	76 50                	jbe    80101f50 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f00:	6a 10                	push   $0x10
80101f02:	57                   	push   %edi
80101f03:	56                   	push   %esi
80101f04:	53                   	push   %ebx
80101f05:	e8 76 fd ff ff       	call   80101c80 <readi>
80101f0a:	83 c4 10             	add    $0x10,%esp
80101f0d:	83 f8 10             	cmp    $0x10,%eax
80101f10:	75 48                	jne    80101f5a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101f12:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f17:	74 df                	je     80101ef8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101f19:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f1c:	83 ec 04             	sub    $0x4,%esp
80101f1f:	6a 0e                	push   $0xe
80101f21:	50                   	push   %eax
80101f22:	ff 75 0c             	pushl  0xc(%ebp)
80101f25:	e8 26 2d 00 00       	call   80104c50 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101f2a:	83 c4 10             	add    $0x10,%esp
80101f2d:	85 c0                	test   %eax,%eax
80101f2f:	75 c7                	jne    80101ef8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101f31:	8b 45 10             	mov    0x10(%ebp),%eax
80101f34:	85 c0                	test   %eax,%eax
80101f36:	74 05                	je     80101f3d <dirlookup+0x6d>
        *poff = off;
80101f38:	8b 45 10             	mov    0x10(%ebp),%eax
80101f3b:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101f3d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101f41:	8b 03                	mov    (%ebx),%eax
80101f43:	e8 f8 f5 ff ff       	call   80101540 <iget>
    }
  }

  return 0;
}
80101f48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f4b:	5b                   	pop    %ebx
80101f4c:	5e                   	pop    %esi
80101f4d:	5f                   	pop    %edi
80101f4e:	5d                   	pop    %ebp
80101f4f:	c3                   	ret    
80101f50:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101f53:	31 c0                	xor    %eax,%eax
}
80101f55:	5b                   	pop    %ebx
80101f56:	5e                   	pop    %esi
80101f57:	5f                   	pop    %edi
80101f58:	5d                   	pop    %ebp
80101f59:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101f5a:	83 ec 0c             	sub    $0xc,%esp
80101f5d:	68 f9 77 10 80       	push   $0x801077f9
80101f62:	e8 09 e4 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101f67:	83 ec 0c             	sub    $0xc,%esp
80101f6a:	68 e7 77 10 80       	push   $0x801077e7
80101f6f:	e8 fc e3 ff ff       	call   80100370 <panic>
80101f74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101f80 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101f80:	55                   	push   %ebp
80101f81:	89 e5                	mov    %esp,%ebp
80101f83:	57                   	push   %edi
80101f84:	56                   	push   %esi
80101f85:	53                   	push   %ebx
80101f86:	89 cf                	mov    %ecx,%edi
80101f88:	89 c3                	mov    %eax,%ebx
80101f8a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101f8d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101f90:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101f93:	0f 84 53 01 00 00    	je     801020ec <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101f99:	e8 22 1b 00 00       	call   80103ac0 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101f9e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101fa1:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101fa4:	68 a0 1c 11 80       	push   $0x80111ca0
80101fa9:	e8 72 2a 00 00       	call   80104a20 <acquire>
  ip->ref++;
80101fae:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101fb2:	c7 04 24 a0 1c 11 80 	movl   $0x80111ca0,(%esp)
80101fb9:	e8 12 2b 00 00       	call   80104ad0 <release>
80101fbe:	83 c4 10             	add    $0x10,%esp
80101fc1:	eb 08                	jmp    80101fcb <namex+0x4b>
80101fc3:	90                   	nop
80101fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101fc8:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101fcb:	0f b6 03             	movzbl (%ebx),%eax
80101fce:	3c 2f                	cmp    $0x2f,%al
80101fd0:	74 f6                	je     80101fc8 <namex+0x48>
    path++;
  if(*path == 0)
80101fd2:	84 c0                	test   %al,%al
80101fd4:	0f 84 e3 00 00 00    	je     801020bd <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101fda:	0f b6 03             	movzbl (%ebx),%eax
80101fdd:	89 da                	mov    %ebx,%edx
80101fdf:	84 c0                	test   %al,%al
80101fe1:	0f 84 ac 00 00 00    	je     80102093 <namex+0x113>
80101fe7:	3c 2f                	cmp    $0x2f,%al
80101fe9:	75 09                	jne    80101ff4 <namex+0x74>
80101feb:	e9 a3 00 00 00       	jmp    80102093 <namex+0x113>
80101ff0:	84 c0                	test   %al,%al
80101ff2:	74 0a                	je     80101ffe <namex+0x7e>
    path++;
80101ff4:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101ff7:	0f b6 02             	movzbl (%edx),%eax
80101ffa:	3c 2f                	cmp    $0x2f,%al
80101ffc:	75 f2                	jne    80101ff0 <namex+0x70>
80101ffe:	89 d1                	mov    %edx,%ecx
80102000:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80102002:	83 f9 0d             	cmp    $0xd,%ecx
80102005:	0f 8e 8d 00 00 00    	jle    80102098 <namex+0x118>
    memmove(name, s, DIRSIZ);
8010200b:	83 ec 04             	sub    $0x4,%esp
8010200e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102011:	6a 0e                	push   $0xe
80102013:	53                   	push   %ebx
80102014:	57                   	push   %edi
80102015:	e8 b6 2b 00 00       	call   80104bd0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
8010201a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
8010201d:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80102020:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102022:	80 3a 2f             	cmpb   $0x2f,(%edx)
80102025:	75 11                	jne    80102038 <namex+0xb8>
80102027:	89 f6                	mov    %esi,%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80102030:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102033:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102036:	74 f8                	je     80102030 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102038:	83 ec 0c             	sub    $0xc,%esp
8010203b:	56                   	push   %esi
8010203c:	e8 5f f9 ff ff       	call   801019a0 <ilock>
    if(ip->type != T_DIR){
80102041:	83 c4 10             	add    $0x10,%esp
80102044:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102049:	0f 85 7f 00 00 00    	jne    801020ce <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
8010204f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102052:	85 d2                	test   %edx,%edx
80102054:	74 09                	je     8010205f <namex+0xdf>
80102056:	80 3b 00             	cmpb   $0x0,(%ebx)
80102059:	0f 84 a3 00 00 00    	je     80102102 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
8010205f:	83 ec 04             	sub    $0x4,%esp
80102062:	6a 00                	push   $0x0
80102064:	57                   	push   %edi
80102065:	56                   	push   %esi
80102066:	e8 65 fe ff ff       	call   80101ed0 <dirlookup>
8010206b:	83 c4 10             	add    $0x10,%esp
8010206e:	85 c0                	test   %eax,%eax
80102070:	74 5c                	je     801020ce <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80102072:	83 ec 0c             	sub    $0xc,%esp
80102075:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102078:	56                   	push   %esi
80102079:	e8 02 fa ff ff       	call   80101a80 <iunlock>
  iput(ip);
8010207e:	89 34 24             	mov    %esi,(%esp)
80102081:	e8 4a fa ff ff       	call   80101ad0 <iput>
80102086:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102089:	83 c4 10             	add    $0x10,%esp
8010208c:	89 c6                	mov    %eax,%esi
8010208e:	e9 38 ff ff ff       	jmp    80101fcb <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102093:	31 c9                	xor    %ecx,%ecx
80102095:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80102098:	83 ec 04             	sub    $0x4,%esp
8010209b:	89 55 dc             	mov    %edx,-0x24(%ebp)
8010209e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801020a1:	51                   	push   %ecx
801020a2:	53                   	push   %ebx
801020a3:	57                   	push   %edi
801020a4:	e8 27 2b 00 00       	call   80104bd0 <memmove>
    name[len] = 0;
801020a9:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801020ac:	8b 55 dc             	mov    -0x24(%ebp),%edx
801020af:	83 c4 10             	add    $0x10,%esp
801020b2:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
801020b6:	89 d3                	mov    %edx,%ebx
801020b8:	e9 65 ff ff ff       	jmp    80102022 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801020bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
801020c0:	85 c0                	test   %eax,%eax
801020c2:	75 54                	jne    80102118 <namex+0x198>
801020c4:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
801020c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020c9:	5b                   	pop    %ebx
801020ca:	5e                   	pop    %esi
801020cb:	5f                   	pop    %edi
801020cc:	5d                   	pop    %ebp
801020cd:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
801020ce:	83 ec 0c             	sub    $0xc,%esp
801020d1:	56                   	push   %esi
801020d2:	e8 a9 f9 ff ff       	call   80101a80 <iunlock>
  iput(ip);
801020d7:	89 34 24             	mov    %esi,(%esp)
801020da:	e8 f1 f9 ff ff       	call   80101ad0 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
801020df:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
801020e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
801020e5:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
801020e7:	5b                   	pop    %ebx
801020e8:	5e                   	pop    %esi
801020e9:	5f                   	pop    %edi
801020ea:	5d                   	pop    %ebp
801020eb:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
801020ec:	ba 01 00 00 00       	mov    $0x1,%edx
801020f1:	b8 01 00 00 00       	mov    $0x1,%eax
801020f6:	e8 45 f4 ff ff       	call   80101540 <iget>
801020fb:	89 c6                	mov    %eax,%esi
801020fd:	e9 c9 fe ff ff       	jmp    80101fcb <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80102102:	83 ec 0c             	sub    $0xc,%esp
80102105:	56                   	push   %esi
80102106:	e8 75 f9 ff ff       	call   80101a80 <iunlock>
      return ip;
8010210b:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
8010210e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80102111:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102113:	5b                   	pop    %ebx
80102114:	5e                   	pop    %esi
80102115:	5f                   	pop    %edi
80102116:	5d                   	pop    %ebp
80102117:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80102118:	83 ec 0c             	sub    $0xc,%esp
8010211b:	56                   	push   %esi
8010211c:	e8 af f9 ff ff       	call   80101ad0 <iput>
    return 0;
80102121:	83 c4 10             	add    $0x10,%esp
80102124:	31 c0                	xor    %eax,%eax
80102126:	eb 9e                	jmp    801020c6 <namex+0x146>
80102128:	90                   	nop
80102129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102130 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102130:	55                   	push   %ebp
80102131:	89 e5                	mov    %esp,%ebp
80102133:	57                   	push   %edi
80102134:	56                   	push   %esi
80102135:	53                   	push   %ebx
80102136:	83 ec 20             	sub    $0x20,%esp
80102139:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
8010213c:	6a 00                	push   $0x0
8010213e:	ff 75 0c             	pushl  0xc(%ebp)
80102141:	53                   	push   %ebx
80102142:	e8 89 fd ff ff       	call   80101ed0 <dirlookup>
80102147:	83 c4 10             	add    $0x10,%esp
8010214a:	85 c0                	test   %eax,%eax
8010214c:	75 67                	jne    801021b5 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010214e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102151:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102154:	85 ff                	test   %edi,%edi
80102156:	74 29                	je     80102181 <dirlink+0x51>
80102158:	31 ff                	xor    %edi,%edi
8010215a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010215d:	eb 09                	jmp    80102168 <dirlink+0x38>
8010215f:	90                   	nop
80102160:	83 c7 10             	add    $0x10,%edi
80102163:	39 7b 58             	cmp    %edi,0x58(%ebx)
80102166:	76 19                	jbe    80102181 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102168:	6a 10                	push   $0x10
8010216a:	57                   	push   %edi
8010216b:	56                   	push   %esi
8010216c:	53                   	push   %ebx
8010216d:	e8 0e fb ff ff       	call   80101c80 <readi>
80102172:	83 c4 10             	add    $0x10,%esp
80102175:	83 f8 10             	cmp    $0x10,%eax
80102178:	75 4e                	jne    801021c8 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
8010217a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010217f:	75 df                	jne    80102160 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80102181:	8d 45 da             	lea    -0x26(%ebp),%eax
80102184:	83 ec 04             	sub    $0x4,%esp
80102187:	6a 0e                	push   $0xe
80102189:	ff 75 0c             	pushl  0xc(%ebp)
8010218c:	50                   	push   %eax
8010218d:	e8 2e 2b 00 00       	call   80104cc0 <strncpy>
  de.inum = inum;
80102192:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102195:	6a 10                	push   $0x10
80102197:	57                   	push   %edi
80102198:	56                   	push   %esi
80102199:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
8010219a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010219e:	e8 dd fb ff ff       	call   80101d80 <writei>
801021a3:	83 c4 20             	add    $0x20,%esp
801021a6:	83 f8 10             	cmp    $0x10,%eax
801021a9:	75 2a                	jne    801021d5 <dirlink+0xa5>
    panic("dirlink");

  return 0;
801021ab:	31 c0                	xor    %eax,%eax
}
801021ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021b0:	5b                   	pop    %ebx
801021b1:	5e                   	pop    %esi
801021b2:	5f                   	pop    %edi
801021b3:	5d                   	pop    %ebp
801021b4:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
801021b5:	83 ec 0c             	sub    $0xc,%esp
801021b8:	50                   	push   %eax
801021b9:	e8 12 f9 ff ff       	call   80101ad0 <iput>
    return -1;
801021be:	83 c4 10             	add    $0x10,%esp
801021c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021c6:	eb e5                	jmp    801021ad <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
801021c8:	83 ec 0c             	sub    $0xc,%esp
801021cb:	68 08 78 10 80       	push   $0x80107808
801021d0:	e8 9b e1 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
801021d5:	83 ec 0c             	sub    $0xc,%esp
801021d8:	68 0e 7f 10 80       	push   $0x80107f0e
801021dd:	e8 8e e1 ff ff       	call   80100370 <panic>
801021e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801021f0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
801021f0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801021f1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
801021f3:	89 e5                	mov    %esp,%ebp
801021f5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
801021f8:	8b 45 08             	mov    0x8(%ebp),%eax
801021fb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801021fe:	e8 7d fd ff ff       	call   80101f80 <namex>
}
80102203:	c9                   	leave  
80102204:	c3                   	ret    
80102205:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102210 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102210:	55                   	push   %ebp
  return namex(path, 1, name);
80102211:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80102216:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102218:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010221b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010221e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
8010221f:	e9 5c fd ff ff       	jmp    80101f80 <namex>
80102224:	66 90                	xchg   %ax,%ax
80102226:	66 90                	xchg   %ax,%ax
80102228:	66 90                	xchg   %ax,%ax
8010222a:	66 90                	xchg   %ax,%ax
8010222c:	66 90                	xchg   %ax,%ax
8010222e:	66 90                	xchg   %ax,%ax

80102230 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102230:	55                   	push   %ebp
  if(b == 0)
80102231:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102233:	89 e5                	mov    %esp,%ebp
80102235:	56                   	push   %esi
80102236:	53                   	push   %ebx
  if(b == 0)
80102237:	0f 84 ad 00 00 00    	je     801022ea <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
8010223d:	8b 58 08             	mov    0x8(%eax),%ebx
80102240:	89 c1                	mov    %eax,%ecx
80102242:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80102248:	0f 87 8f 00 00 00    	ja     801022dd <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010224e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102253:	90                   	nop
80102254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102258:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102259:	83 e0 c0             	and    $0xffffffc0,%eax
8010225c:	3c 40                	cmp    $0x40,%al
8010225e:	75 f8                	jne    80102258 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102260:	31 f6                	xor    %esi,%esi
80102262:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102267:	89 f0                	mov    %esi,%eax
80102269:	ee                   	out    %al,(%dx)
8010226a:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010226f:	b8 01 00 00 00       	mov    $0x1,%eax
80102274:	ee                   	out    %al,(%dx)
80102275:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010227a:	89 d8                	mov    %ebx,%eax
8010227c:	ee                   	out    %al,(%dx)
8010227d:	89 d8                	mov    %ebx,%eax
8010227f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102284:	c1 f8 08             	sar    $0x8,%eax
80102287:	ee                   	out    %al,(%dx)
80102288:	ba f5 01 00 00       	mov    $0x1f5,%edx
8010228d:	89 f0                	mov    %esi,%eax
8010228f:	ee                   	out    %al,(%dx)
80102290:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80102294:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102299:	83 e0 01             	and    $0x1,%eax
8010229c:	c1 e0 04             	shl    $0x4,%eax
8010229f:	83 c8 e0             	or     $0xffffffe0,%eax
801022a2:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
801022a3:	f6 01 04             	testb  $0x4,(%ecx)
801022a6:	ba f7 01 00 00       	mov    $0x1f7,%edx
801022ab:	75 13                	jne    801022c0 <idestart+0x90>
801022ad:	b8 20 00 00 00       	mov    $0x20,%eax
801022b2:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801022b3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022b6:	5b                   	pop    %ebx
801022b7:	5e                   	pop    %esi
801022b8:	5d                   	pop    %ebp
801022b9:	c3                   	ret    
801022ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801022c0:	b8 30 00 00 00       	mov    $0x30,%eax
801022c5:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
801022c6:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
801022cb:	8d 71 5c             	lea    0x5c(%ecx),%esi
801022ce:	b9 80 00 00 00       	mov    $0x80,%ecx
801022d3:	fc                   	cld    
801022d4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
801022d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022d9:	5b                   	pop    %ebx
801022da:	5e                   	pop    %esi
801022db:	5d                   	pop    %ebp
801022dc:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
801022dd:	83 ec 0c             	sub    $0xc,%esp
801022e0:	68 74 78 10 80       	push   $0x80107874
801022e5:	e8 86 e0 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
801022ea:	83 ec 0c             	sub    $0xc,%esp
801022ed:	68 6b 78 10 80       	push   $0x8010786b
801022f2:	e8 79 e0 ff ff       	call   80100370 <panic>
801022f7:	89 f6                	mov    %esi,%esi
801022f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102300 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102300:	55                   	push   %ebp
80102301:	89 e5                	mov    %esp,%ebp
80102303:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80102306:	68 86 78 10 80       	push   $0x80107886
8010230b:	68 c0 b5 10 80       	push   $0x8010b5c0
80102310:	e8 ab 25 00 00       	call   801048c0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102315:	58                   	pop    %eax
80102316:	a1 c0 3f 11 80       	mov    0x80113fc0,%eax
8010231b:	5a                   	pop    %edx
8010231c:	83 e8 01             	sub    $0x1,%eax
8010231f:	50                   	push   %eax
80102320:	6a 0e                	push   $0xe
80102322:	e8 a9 02 00 00       	call   801025d0 <ioapicenable>
80102327:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010232a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010232f:	90                   	nop
80102330:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102331:	83 e0 c0             	and    $0xffffffc0,%eax
80102334:	3c 40                	cmp    $0x40,%al
80102336:	75 f8                	jne    80102330 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102338:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010233d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102342:	ee                   	out    %al,(%dx)
80102343:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102348:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010234d:	eb 06                	jmp    80102355 <ideinit+0x55>
8010234f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102350:	83 e9 01             	sub    $0x1,%ecx
80102353:	74 0f                	je     80102364 <ideinit+0x64>
80102355:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102356:	84 c0                	test   %al,%al
80102358:	74 f6                	je     80102350 <ideinit+0x50>
      havedisk1 = 1;
8010235a:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
80102361:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102364:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102369:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010236e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010236f:	c9                   	leave  
80102370:	c3                   	ret    
80102371:	eb 0d                	jmp    80102380 <ideintr>
80102373:	90                   	nop
80102374:	90                   	nop
80102375:	90                   	nop
80102376:	90                   	nop
80102377:	90                   	nop
80102378:	90                   	nop
80102379:	90                   	nop
8010237a:	90                   	nop
8010237b:	90                   	nop
8010237c:	90                   	nop
8010237d:	90                   	nop
8010237e:	90                   	nop
8010237f:	90                   	nop

80102380 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102380:	55                   	push   %ebp
80102381:	89 e5                	mov    %esp,%ebp
80102383:	57                   	push   %edi
80102384:	56                   	push   %esi
80102385:	53                   	push   %ebx
80102386:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102389:	68 c0 b5 10 80       	push   $0x8010b5c0
8010238e:	e8 8d 26 00 00       	call   80104a20 <acquire>

  if((b = idequeue) == 0){
80102393:	8b 1d a4 b5 10 80    	mov    0x8010b5a4,%ebx
80102399:	83 c4 10             	add    $0x10,%esp
8010239c:	85 db                	test   %ebx,%ebx
8010239e:	74 34                	je     801023d4 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801023a0:	8b 43 58             	mov    0x58(%ebx),%eax
801023a3:	a3 a4 b5 10 80       	mov    %eax,0x8010b5a4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801023a8:	8b 33                	mov    (%ebx),%esi
801023aa:	f7 c6 04 00 00 00    	test   $0x4,%esi
801023b0:	74 3e                	je     801023f0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801023b2:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801023b5:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801023b8:	83 ce 02             	or     $0x2,%esi
801023bb:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801023bd:	53                   	push   %ebx
801023be:	e8 6d 1e 00 00       	call   80104230 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801023c3:	a1 a4 b5 10 80       	mov    0x8010b5a4,%eax
801023c8:	83 c4 10             	add    $0x10,%esp
801023cb:	85 c0                	test   %eax,%eax
801023cd:	74 05                	je     801023d4 <ideintr+0x54>
    idestart(idequeue);
801023cf:	e8 5c fe ff ff       	call   80102230 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
801023d4:	83 ec 0c             	sub    $0xc,%esp
801023d7:	68 c0 b5 10 80       	push   $0x8010b5c0
801023dc:	e8 ef 26 00 00       	call   80104ad0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
801023e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023e4:	5b                   	pop    %ebx
801023e5:	5e                   	pop    %esi
801023e6:	5f                   	pop    %edi
801023e7:	5d                   	pop    %ebp
801023e8:	c3                   	ret    
801023e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023f0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023f5:	8d 76 00             	lea    0x0(%esi),%esi
801023f8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801023f9:	89 c1                	mov    %eax,%ecx
801023fb:	83 e1 c0             	and    $0xffffffc0,%ecx
801023fe:	80 f9 40             	cmp    $0x40,%cl
80102401:	75 f5                	jne    801023f8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102403:	a8 21                	test   $0x21,%al
80102405:	75 ab                	jne    801023b2 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80102407:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
8010240a:	b9 80 00 00 00       	mov    $0x80,%ecx
8010240f:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102414:	fc                   	cld    
80102415:	f3 6d                	rep insl (%dx),%es:(%edi)
80102417:	8b 33                	mov    (%ebx),%esi
80102419:	eb 97                	jmp    801023b2 <ideintr+0x32>
8010241b:	90                   	nop
8010241c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102420 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	53                   	push   %ebx
80102424:	83 ec 10             	sub    $0x10,%esp
80102427:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010242a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010242d:	50                   	push   %eax
8010242e:	e8 3d 24 00 00       	call   80104870 <holdingsleep>
80102433:	83 c4 10             	add    $0x10,%esp
80102436:	85 c0                	test   %eax,%eax
80102438:	0f 84 ad 00 00 00    	je     801024eb <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010243e:	8b 03                	mov    (%ebx),%eax
80102440:	83 e0 06             	and    $0x6,%eax
80102443:	83 f8 02             	cmp    $0x2,%eax
80102446:	0f 84 b9 00 00 00    	je     80102505 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010244c:	8b 53 04             	mov    0x4(%ebx),%edx
8010244f:	85 d2                	test   %edx,%edx
80102451:	74 0d                	je     80102460 <iderw+0x40>
80102453:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
80102458:	85 c0                	test   %eax,%eax
8010245a:	0f 84 98 00 00 00    	je     801024f8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102460:	83 ec 0c             	sub    $0xc,%esp
80102463:	68 c0 b5 10 80       	push   $0x8010b5c0
80102468:	e8 b3 25 00 00       	call   80104a20 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010246d:	8b 15 a4 b5 10 80    	mov    0x8010b5a4,%edx
80102473:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102476:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010247d:	85 d2                	test   %edx,%edx
8010247f:	75 09                	jne    8010248a <iderw+0x6a>
80102481:	eb 58                	jmp    801024db <iderw+0xbb>
80102483:	90                   	nop
80102484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102488:	89 c2                	mov    %eax,%edx
8010248a:	8b 42 58             	mov    0x58(%edx),%eax
8010248d:	85 c0                	test   %eax,%eax
8010248f:	75 f7                	jne    80102488 <iderw+0x68>
80102491:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102494:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102496:	3b 1d a4 b5 10 80    	cmp    0x8010b5a4,%ebx
8010249c:	74 44                	je     801024e2 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010249e:	8b 03                	mov    (%ebx),%eax
801024a0:	83 e0 06             	and    $0x6,%eax
801024a3:	83 f8 02             	cmp    $0x2,%eax
801024a6:	74 23                	je     801024cb <iderw+0xab>
801024a8:	90                   	nop
801024a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801024b0:	83 ec 08             	sub    $0x8,%esp
801024b3:	68 c0 b5 10 80       	push   $0x8010b5c0
801024b8:	53                   	push   %ebx
801024b9:	e8 b2 1b 00 00       	call   80104070 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801024be:	8b 03                	mov    (%ebx),%eax
801024c0:	83 c4 10             	add    $0x10,%esp
801024c3:	83 e0 06             	and    $0x6,%eax
801024c6:	83 f8 02             	cmp    $0x2,%eax
801024c9:	75 e5                	jne    801024b0 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
801024cb:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
801024d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024d5:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
801024d6:	e9 f5 25 00 00       	jmp    80104ad0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024db:	ba a4 b5 10 80       	mov    $0x8010b5a4,%edx
801024e0:	eb b2                	jmp    80102494 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801024e2:	89 d8                	mov    %ebx,%eax
801024e4:	e8 47 fd ff ff       	call   80102230 <idestart>
801024e9:	eb b3                	jmp    8010249e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801024eb:	83 ec 0c             	sub    $0xc,%esp
801024ee:	68 8a 78 10 80       	push   $0x8010788a
801024f3:	e8 78 de ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801024f8:	83 ec 0c             	sub    $0xc,%esp
801024fb:	68 b5 78 10 80       	push   $0x801078b5
80102500:	e8 6b de ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102505:	83 ec 0c             	sub    $0xc,%esp
80102508:	68 a0 78 10 80       	push   $0x801078a0
8010250d:	e8 5e de ff ff       	call   80100370 <panic>
80102512:	66 90                	xchg   %ax,%ax
80102514:	66 90                	xchg   %ax,%ax
80102516:	66 90                	xchg   %ax,%ax
80102518:	66 90                	xchg   %ax,%ax
8010251a:	66 90                	xchg   %ax,%ax
8010251c:	66 90                	xchg   %ax,%ax
8010251e:	66 90                	xchg   %ax,%ax

80102520 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102520:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102521:	c7 05 f4 38 11 80 00 	movl   $0xfec00000,0x801138f4
80102528:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010252b:	89 e5                	mov    %esp,%ebp
8010252d:	56                   	push   %esi
8010252e:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010252f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102536:	00 00 00 
  return ioapic->data;
80102539:	8b 15 f4 38 11 80    	mov    0x801138f4,%edx
8010253f:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102542:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102548:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010254e:	0f b6 15 20 3a 11 80 	movzbl 0x80113a20,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102555:	89 f0                	mov    %esi,%eax
80102557:	c1 e8 10             	shr    $0x10,%eax
8010255a:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010255d:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102560:	c1 e8 18             	shr    $0x18,%eax
80102563:	39 d0                	cmp    %edx,%eax
80102565:	74 16                	je     8010257d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102567:	83 ec 0c             	sub    $0xc,%esp
8010256a:	68 d4 78 10 80       	push   $0x801078d4
8010256f:	e8 ec e0 ff ff       	call   80100660 <cprintf>
80102574:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
8010257a:	83 c4 10             	add    $0x10,%esp
8010257d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102580:	ba 10 00 00 00       	mov    $0x10,%edx
80102585:	b8 20 00 00 00       	mov    $0x20,%eax
8010258a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102590:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102592:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102598:	89 c3                	mov    %eax,%ebx
8010259a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
801025a0:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801025a3:	89 59 10             	mov    %ebx,0x10(%ecx)
801025a6:	8d 5a 01             	lea    0x1(%edx),%ebx
801025a9:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801025ac:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801025ae:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801025b0:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
801025b6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801025bd:	75 d1                	jne    80102590 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801025bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025c2:	5b                   	pop    %ebx
801025c3:	5e                   	pop    %esi
801025c4:	5d                   	pop    %ebp
801025c5:	c3                   	ret    
801025c6:	8d 76 00             	lea    0x0(%esi),%esi
801025c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025d0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801025d0:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801025d1:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
801025d7:	89 e5                	mov    %esp,%ebp
801025d9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801025dc:	8d 50 20             	lea    0x20(%eax),%edx
801025df:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801025e3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801025e5:	8b 0d f4 38 11 80    	mov    0x801138f4,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801025eb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801025ee:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025f1:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801025f4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801025f6:	a1 f4 38 11 80       	mov    0x801138f4,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025fb:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801025fe:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102601:	5d                   	pop    %ebp
80102602:	c3                   	ret    
80102603:	66 90                	xchg   %ax,%ax
80102605:	66 90                	xchg   %ax,%ax
80102607:	66 90                	xchg   %ax,%ax
80102609:	66 90                	xchg   %ax,%ax
8010260b:	66 90                	xchg   %ax,%ax
8010260d:	66 90                	xchg   %ax,%ax
8010260f:	90                   	nop

80102610 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	53                   	push   %ebx
80102614:	83 ec 04             	sub    $0x4,%esp
80102617:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010261a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102620:	75 70                	jne    80102692 <kfree+0x82>
80102622:	81 fb 68 69 11 80    	cmp    $0x80116968,%ebx
80102628:	72 68                	jb     80102692 <kfree+0x82>
8010262a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102630:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102635:	77 5b                	ja     80102692 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102637:	83 ec 04             	sub    $0x4,%esp
8010263a:	68 00 10 00 00       	push   $0x1000
8010263f:	6a 01                	push   $0x1
80102641:	53                   	push   %ebx
80102642:	e8 d9 24 00 00       	call   80104b20 <memset>

  if(kmem.use_lock)
80102647:	8b 15 34 39 11 80    	mov    0x80113934,%edx
8010264d:	83 c4 10             	add    $0x10,%esp
80102650:	85 d2                	test   %edx,%edx
80102652:	75 2c                	jne    80102680 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102654:	a1 38 39 11 80       	mov    0x80113938,%eax
80102659:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010265b:	a1 34 39 11 80       	mov    0x80113934,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102660:	89 1d 38 39 11 80    	mov    %ebx,0x80113938
  if(kmem.use_lock)
80102666:	85 c0                	test   %eax,%eax
80102668:	75 06                	jne    80102670 <kfree+0x60>
    release(&kmem.lock);
}
8010266a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010266d:	c9                   	leave  
8010266e:	c3                   	ret    
8010266f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102670:	c7 45 08 00 39 11 80 	movl   $0x80113900,0x8(%ebp)
}
80102677:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010267a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010267b:	e9 50 24 00 00       	jmp    80104ad0 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102680:	83 ec 0c             	sub    $0xc,%esp
80102683:	68 00 39 11 80       	push   $0x80113900
80102688:	e8 93 23 00 00       	call   80104a20 <acquire>
8010268d:	83 c4 10             	add    $0x10,%esp
80102690:	eb c2                	jmp    80102654 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102692:	83 ec 0c             	sub    $0xc,%esp
80102695:	68 06 79 10 80       	push   $0x80107906
8010269a:	e8 d1 dc ff ff       	call   80100370 <panic>
8010269f:	90                   	nop

801026a0 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801026a0:	55                   	push   %ebp
801026a1:	89 e5                	mov    %esp,%ebp
801026a3:	56                   	push   %esi
801026a4:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801026a5:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801026a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801026ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026bd:	39 de                	cmp    %ebx,%esi
801026bf:	72 23                	jb     801026e4 <freerange+0x44>
801026c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801026c8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801026ce:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026d7:	50                   	push   %eax
801026d8:	e8 33 ff ff ff       	call   80102610 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026dd:	83 c4 10             	add    $0x10,%esp
801026e0:	39 f3                	cmp    %esi,%ebx
801026e2:	76 e4                	jbe    801026c8 <freerange+0x28>
    kfree(p);
}
801026e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026e7:	5b                   	pop    %ebx
801026e8:	5e                   	pop    %esi
801026e9:	5d                   	pop    %ebp
801026ea:	c3                   	ret    
801026eb:	90                   	nop
801026ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801026f0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801026f0:	55                   	push   %ebp
801026f1:	89 e5                	mov    %esp,%ebp
801026f3:	56                   	push   %esi
801026f4:	53                   	push   %ebx
801026f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801026f8:	83 ec 08             	sub    $0x8,%esp
801026fb:	68 0c 79 10 80       	push   $0x8010790c
80102700:	68 00 39 11 80       	push   $0x80113900
80102705:	e8 b6 21 00 00       	call   801048c0 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010270a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010270d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102710:	c7 05 34 39 11 80 00 	movl   $0x0,0x80113934
80102717:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010271a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102720:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102726:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010272c:	39 de                	cmp    %ebx,%esi
8010272e:	72 1c                	jb     8010274c <kinit1+0x5c>
    kfree(p);
80102730:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102736:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102739:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010273f:	50                   	push   %eax
80102740:	e8 cb fe ff ff       	call   80102610 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102745:	83 c4 10             	add    $0x10,%esp
80102748:	39 de                	cmp    %ebx,%esi
8010274a:	73 e4                	jae    80102730 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010274c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010274f:	5b                   	pop    %ebx
80102750:	5e                   	pop    %esi
80102751:	5d                   	pop    %ebp
80102752:	c3                   	ret    
80102753:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102760:	55                   	push   %ebp
80102761:	89 e5                	mov    %esp,%ebp
80102763:	56                   	push   %esi
80102764:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102765:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102768:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010276b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102771:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102777:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010277d:	39 de                	cmp    %ebx,%esi
8010277f:	72 23                	jb     801027a4 <kinit2+0x44>
80102781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102788:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010278e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102791:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102797:	50                   	push   %eax
80102798:	e8 73 fe ff ff       	call   80102610 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010279d:	83 c4 10             	add    $0x10,%esp
801027a0:	39 de                	cmp    %ebx,%esi
801027a2:	73 e4                	jae    80102788 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
801027a4:	c7 05 34 39 11 80 01 	movl   $0x1,0x80113934
801027ab:	00 00 00 
}
801027ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027b1:	5b                   	pop    %ebx
801027b2:	5e                   	pop    %esi
801027b3:	5d                   	pop    %ebp
801027b4:	c3                   	ret    
801027b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027c0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801027c0:	55                   	push   %ebp
801027c1:	89 e5                	mov    %esp,%ebp
801027c3:	53                   	push   %ebx
801027c4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801027c7:	a1 34 39 11 80       	mov    0x80113934,%eax
801027cc:	85 c0                	test   %eax,%eax
801027ce:	75 30                	jne    80102800 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801027d0:	8b 1d 38 39 11 80    	mov    0x80113938,%ebx
  if(r)
801027d6:	85 db                	test   %ebx,%ebx
801027d8:	74 1c                	je     801027f6 <kalloc+0x36>
    kmem.freelist = r->next;
801027da:	8b 13                	mov    (%ebx),%edx
801027dc:	89 15 38 39 11 80    	mov    %edx,0x80113938
  if(kmem.use_lock)
801027e2:	85 c0                	test   %eax,%eax
801027e4:	74 10                	je     801027f6 <kalloc+0x36>
    release(&kmem.lock);
801027e6:	83 ec 0c             	sub    $0xc,%esp
801027e9:	68 00 39 11 80       	push   $0x80113900
801027ee:	e8 dd 22 00 00       	call   80104ad0 <release>
801027f3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801027f6:	89 d8                	mov    %ebx,%eax
801027f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027fb:	c9                   	leave  
801027fc:	c3                   	ret    
801027fd:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102800:	83 ec 0c             	sub    $0xc,%esp
80102803:	68 00 39 11 80       	push   $0x80113900
80102808:	e8 13 22 00 00       	call   80104a20 <acquire>
  r = kmem.freelist;
8010280d:	8b 1d 38 39 11 80    	mov    0x80113938,%ebx
  if(r)
80102813:	83 c4 10             	add    $0x10,%esp
80102816:	a1 34 39 11 80       	mov    0x80113934,%eax
8010281b:	85 db                	test   %ebx,%ebx
8010281d:	75 bb                	jne    801027da <kalloc+0x1a>
8010281f:	eb c1                	jmp    801027e2 <kalloc+0x22>
80102821:	66 90                	xchg   %ax,%ax
80102823:	66 90                	xchg   %ax,%ax
80102825:	66 90                	xchg   %ax,%ax
80102827:	66 90                	xchg   %ax,%ax
80102829:	66 90                	xchg   %ax,%ax
8010282b:	66 90                	xchg   %ax,%ax
8010282d:	66 90                	xchg   %ax,%ax
8010282f:	90                   	nop

80102830 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102830:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102831:	ba 64 00 00 00       	mov    $0x64,%edx
80102836:	89 e5                	mov    %esp,%ebp
80102838:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102839:	a8 01                	test   $0x1,%al
8010283b:	0f 84 af 00 00 00    	je     801028f0 <kbdgetc+0xc0>
80102841:	ba 60 00 00 00       	mov    $0x60,%edx
80102846:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102847:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010284a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102850:	74 7e                	je     801028d0 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102852:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102854:	8b 0d f4 b5 10 80    	mov    0x8010b5f4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010285a:	79 24                	jns    80102880 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010285c:	f6 c1 40             	test   $0x40,%cl
8010285f:	75 05                	jne    80102866 <kbdgetc+0x36>
80102861:	89 c2                	mov    %eax,%edx
80102863:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102866:	0f b6 82 40 7a 10 80 	movzbl -0x7fef85c0(%edx),%eax
8010286d:	83 c8 40             	or     $0x40,%eax
80102870:	0f b6 c0             	movzbl %al,%eax
80102873:	f7 d0                	not    %eax
80102875:	21 c8                	and    %ecx,%eax
80102877:	a3 f4 b5 10 80       	mov    %eax,0x8010b5f4
    return 0;
8010287c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010287e:	5d                   	pop    %ebp
8010287f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102880:	f6 c1 40             	test   $0x40,%cl
80102883:	74 09                	je     8010288e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102885:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102888:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010288b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010288e:	0f b6 82 40 7a 10 80 	movzbl -0x7fef85c0(%edx),%eax
80102895:	09 c1                	or     %eax,%ecx
80102897:	0f b6 82 40 79 10 80 	movzbl -0x7fef86c0(%edx),%eax
8010289e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801028a0:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801028a2:	89 0d f4 b5 10 80    	mov    %ecx,0x8010b5f4
  c = charcode[shift & (CTL | SHIFT)][data];
801028a8:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801028ab:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
801028ae:	8b 04 85 20 79 10 80 	mov    -0x7fef86e0(,%eax,4),%eax
801028b5:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801028b9:	74 c3                	je     8010287e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
801028bb:	8d 50 9f             	lea    -0x61(%eax),%edx
801028be:	83 fa 19             	cmp    $0x19,%edx
801028c1:	77 1d                	ja     801028e0 <kbdgetc+0xb0>
      c += 'A' - 'a';
801028c3:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801028c6:	5d                   	pop    %ebp
801028c7:	c3                   	ret    
801028c8:	90                   	nop
801028c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
801028d0:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801028d2:	83 0d f4 b5 10 80 40 	orl    $0x40,0x8010b5f4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801028d9:	5d                   	pop    %ebp
801028da:	c3                   	ret    
801028db:	90                   	nop
801028dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801028e0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801028e3:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
801028e6:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
801028e7:	83 f9 19             	cmp    $0x19,%ecx
801028ea:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801028ed:	c3                   	ret    
801028ee:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801028f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801028f5:	5d                   	pop    %ebp
801028f6:	c3                   	ret    
801028f7:	89 f6                	mov    %esi,%esi
801028f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102900 <kbdintr>:

void
kbdintr(void)
{
80102900:	55                   	push   %ebp
80102901:	89 e5                	mov    %esp,%ebp
80102903:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102906:	68 30 28 10 80       	push   $0x80102830
8010290b:	e8 c0 e1 ff ff       	call   80100ad0 <consoleintr>
}
80102910:	83 c4 10             	add    $0x10,%esp
80102913:	c9                   	leave  
80102914:	c3                   	ret    
80102915:	66 90                	xchg   %ax,%ax
80102917:	66 90                	xchg   %ax,%ax
80102919:	66 90                	xchg   %ax,%ax
8010291b:	66 90                	xchg   %ax,%ax
8010291d:	66 90                	xchg   %ax,%ax
8010291f:	90                   	nop

80102920 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102920:	a1 3c 39 11 80       	mov    0x8011393c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102925:	55                   	push   %ebp
80102926:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102928:	85 c0                	test   %eax,%eax
8010292a:	0f 84 c8 00 00 00    	je     801029f8 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102930:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102937:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010293a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010293d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102944:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102947:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010294a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102951:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102954:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102957:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010295e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102961:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102964:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010296b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010296e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102971:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102978:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010297b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010297e:	8b 50 30             	mov    0x30(%eax),%edx
80102981:	c1 ea 10             	shr    $0x10,%edx
80102984:	80 fa 03             	cmp    $0x3,%dl
80102987:	77 77                	ja     80102a00 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102989:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102990:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102993:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102996:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010299d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029a0:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029a3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801029aa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029ad:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029b0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801029b7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029ba:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029bd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801029c4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029c7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029ca:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801029d1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801029d4:	8b 50 20             	mov    0x20(%eax),%edx
801029d7:	89 f6                	mov    %esi,%esi
801029d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801029e0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801029e6:	80 e6 10             	and    $0x10,%dh
801029e9:	75 f5                	jne    801029e0 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801029eb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801029f2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029f5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801029f8:	5d                   	pop    %ebp
801029f9:	c3                   	ret    
801029fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a00:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102a07:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a0a:	8b 50 20             	mov    0x20(%eax),%edx
80102a0d:	e9 77 ff ff ff       	jmp    80102989 <lapicinit+0x69>
80102a12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a20 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
80102a20:	a1 3c 39 11 80       	mov    0x8011393c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80102a25:	55                   	push   %ebp
80102a26:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102a28:	85 c0                	test   %eax,%eax
80102a2a:	74 0c                	je     80102a38 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
80102a2c:	8b 40 20             	mov    0x20(%eax),%eax
}
80102a2f:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80102a30:	c1 e8 18             	shr    $0x18,%eax
}
80102a33:	c3                   	ret    
80102a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
80102a38:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
80102a3a:	5d                   	pop    %ebp
80102a3b:	c3                   	ret    
80102a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102a40 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102a40:	a1 3c 39 11 80       	mov    0x8011393c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102a45:	55                   	push   %ebp
80102a46:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102a48:	85 c0                	test   %eax,%eax
80102a4a:	74 0d                	je     80102a59 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a4c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a53:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a56:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102a59:	5d                   	pop    %ebp
80102a5a:	c3                   	ret    
80102a5b:	90                   	nop
80102a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102a60 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102a60:	55                   	push   %ebp
80102a61:	89 e5                	mov    %esp,%ebp
}
80102a63:	5d                   	pop    %ebp
80102a64:	c3                   	ret    
80102a65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a70 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102a70:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a71:	ba 70 00 00 00       	mov    $0x70,%edx
80102a76:	b8 0f 00 00 00       	mov    $0xf,%eax
80102a7b:	89 e5                	mov    %esp,%ebp
80102a7d:	53                   	push   %ebx
80102a7e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102a81:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102a84:	ee                   	out    %al,(%dx)
80102a85:	ba 71 00 00 00       	mov    $0x71,%edx
80102a8a:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a8f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102a90:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102a92:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102a95:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102a9b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a9d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102aa0:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102aa3:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102aa5:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102aa8:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102aae:	a1 3c 39 11 80       	mov    0x8011393c,%eax
80102ab3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ab9:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102abc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102ac3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ac6:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102ac9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102ad0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ad3:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102ad6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102adc:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102adf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ae5:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102ae8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102aee:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102af1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102af7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80102afa:	5b                   	pop    %ebx
80102afb:	5d                   	pop    %ebp
80102afc:	c3                   	ret    
80102afd:	8d 76 00             	lea    0x0(%esi),%esi

80102b00 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102b00:	55                   	push   %ebp
80102b01:	ba 70 00 00 00       	mov    $0x70,%edx
80102b06:	b8 0b 00 00 00       	mov    $0xb,%eax
80102b0b:	89 e5                	mov    %esp,%ebp
80102b0d:	57                   	push   %edi
80102b0e:	56                   	push   %esi
80102b0f:	53                   	push   %ebx
80102b10:	83 ec 4c             	sub    $0x4c,%esp
80102b13:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b14:	ba 71 00 00 00       	mov    $0x71,%edx
80102b19:	ec                   	in     (%dx),%al
80102b1a:	83 e0 04             	and    $0x4,%eax
80102b1d:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b20:	31 db                	xor    %ebx,%ebx
80102b22:	88 45 b7             	mov    %al,-0x49(%ebp)
80102b25:	bf 70 00 00 00       	mov    $0x70,%edi
80102b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b30:	89 d8                	mov    %ebx,%eax
80102b32:	89 fa                	mov    %edi,%edx
80102b34:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b35:	b9 71 00 00 00       	mov    $0x71,%ecx
80102b3a:	89 ca                	mov    %ecx,%edx
80102b3c:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
80102b3d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b40:	89 fa                	mov    %edi,%edx
80102b42:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102b45:	b8 02 00 00 00       	mov    $0x2,%eax
80102b4a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b4b:	89 ca                	mov    %ecx,%edx
80102b4d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102b4e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b51:	89 fa                	mov    %edi,%edx
80102b53:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102b56:	b8 04 00 00 00       	mov    $0x4,%eax
80102b5b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b5c:	89 ca                	mov    %ecx,%edx
80102b5e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102b5f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b62:	89 fa                	mov    %edi,%edx
80102b64:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102b67:	b8 07 00 00 00       	mov    $0x7,%eax
80102b6c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b6d:	89 ca                	mov    %ecx,%edx
80102b6f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102b70:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b73:	89 fa                	mov    %edi,%edx
80102b75:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102b78:	b8 08 00 00 00       	mov    $0x8,%eax
80102b7d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b7e:	89 ca                	mov    %ecx,%edx
80102b80:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102b81:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b84:	89 fa                	mov    %edi,%edx
80102b86:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102b89:	b8 09 00 00 00       	mov    $0x9,%eax
80102b8e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b8f:	89 ca                	mov    %ecx,%edx
80102b91:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102b92:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b95:	89 fa                	mov    %edi,%edx
80102b97:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102b9a:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b9f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ba0:	89 ca                	mov    %ecx,%edx
80102ba2:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102ba3:	84 c0                	test   %al,%al
80102ba5:	78 89                	js     80102b30 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ba7:	89 d8                	mov    %ebx,%eax
80102ba9:	89 fa                	mov    %edi,%edx
80102bab:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bac:	89 ca                	mov    %ecx,%edx
80102bae:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
80102baf:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bb2:	89 fa                	mov    %edi,%edx
80102bb4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102bb7:	b8 02 00 00 00       	mov    $0x2,%eax
80102bbc:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bbd:	89 ca                	mov    %ecx,%edx
80102bbf:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102bc0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bc3:	89 fa                	mov    %edi,%edx
80102bc5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102bc8:	b8 04 00 00 00       	mov    $0x4,%eax
80102bcd:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bce:	89 ca                	mov    %ecx,%edx
80102bd0:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102bd1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bd4:	89 fa                	mov    %edi,%edx
80102bd6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102bd9:	b8 07 00 00 00       	mov    $0x7,%eax
80102bde:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bdf:	89 ca                	mov    %ecx,%edx
80102be1:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102be2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102be5:	89 fa                	mov    %edi,%edx
80102be7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102bea:	b8 08 00 00 00       	mov    $0x8,%eax
80102bef:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bf0:	89 ca                	mov    %ecx,%edx
80102bf2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102bf3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bf6:	89 fa                	mov    %edi,%edx
80102bf8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102bfb:	b8 09 00 00 00       	mov    $0x9,%eax
80102c00:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c01:	89 ca                	mov    %ecx,%edx
80102c03:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102c04:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c07:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
80102c0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c0d:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102c10:	6a 18                	push   $0x18
80102c12:	56                   	push   %esi
80102c13:	50                   	push   %eax
80102c14:	e8 57 1f 00 00       	call   80104b70 <memcmp>
80102c19:	83 c4 10             	add    $0x10,%esp
80102c1c:	85 c0                	test   %eax,%eax
80102c1e:	0f 85 0c ff ff ff    	jne    80102b30 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102c24:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102c28:	75 78                	jne    80102ca2 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102c2a:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102c2d:	89 c2                	mov    %eax,%edx
80102c2f:	83 e0 0f             	and    $0xf,%eax
80102c32:	c1 ea 04             	shr    $0x4,%edx
80102c35:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c38:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c3b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102c3e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102c41:	89 c2                	mov    %eax,%edx
80102c43:	83 e0 0f             	and    $0xf,%eax
80102c46:	c1 ea 04             	shr    $0x4,%edx
80102c49:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c4c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c4f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102c52:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102c55:	89 c2                	mov    %eax,%edx
80102c57:	83 e0 0f             	and    $0xf,%eax
80102c5a:	c1 ea 04             	shr    $0x4,%edx
80102c5d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c60:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c63:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102c66:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102c69:	89 c2                	mov    %eax,%edx
80102c6b:	83 e0 0f             	and    $0xf,%eax
80102c6e:	c1 ea 04             	shr    $0x4,%edx
80102c71:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c74:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c77:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102c7a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102c7d:	89 c2                	mov    %eax,%edx
80102c7f:	83 e0 0f             	and    $0xf,%eax
80102c82:	c1 ea 04             	shr    $0x4,%edx
80102c85:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c88:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c8b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102c8e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102c91:	89 c2                	mov    %eax,%edx
80102c93:	83 e0 0f             	and    $0xf,%eax
80102c96:	c1 ea 04             	shr    $0x4,%edx
80102c99:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c9c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c9f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102ca2:	8b 75 08             	mov    0x8(%ebp),%esi
80102ca5:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ca8:	89 06                	mov    %eax,(%esi)
80102caa:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102cad:	89 46 04             	mov    %eax,0x4(%esi)
80102cb0:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102cb3:	89 46 08             	mov    %eax,0x8(%esi)
80102cb6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102cb9:	89 46 0c             	mov    %eax,0xc(%esi)
80102cbc:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102cbf:	89 46 10             	mov    %eax,0x10(%esi)
80102cc2:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102cc5:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102cc8:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102ccf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cd2:	5b                   	pop    %ebx
80102cd3:	5e                   	pop    %esi
80102cd4:	5f                   	pop    %edi
80102cd5:	5d                   	pop    %ebp
80102cd6:	c3                   	ret    
80102cd7:	66 90                	xchg   %ax,%ax
80102cd9:	66 90                	xchg   %ax,%ax
80102cdb:	66 90                	xchg   %ax,%ax
80102cdd:	66 90                	xchg   %ax,%ax
80102cdf:	90                   	nop

80102ce0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ce0:	8b 0d 88 39 11 80    	mov    0x80113988,%ecx
80102ce6:	85 c9                	test   %ecx,%ecx
80102ce8:	0f 8e 85 00 00 00    	jle    80102d73 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102cee:	55                   	push   %ebp
80102cef:	89 e5                	mov    %esp,%ebp
80102cf1:	57                   	push   %edi
80102cf2:	56                   	push   %esi
80102cf3:	53                   	push   %ebx
80102cf4:	31 db                	xor    %ebx,%ebx
80102cf6:	83 ec 0c             	sub    $0xc,%esp
80102cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102d00:	a1 74 39 11 80       	mov    0x80113974,%eax
80102d05:	83 ec 08             	sub    $0x8,%esp
80102d08:	01 d8                	add    %ebx,%eax
80102d0a:	83 c0 01             	add    $0x1,%eax
80102d0d:	50                   	push   %eax
80102d0e:	ff 35 84 39 11 80    	pushl  0x80113984
80102d14:	e8 b7 d3 ff ff       	call   801000d0 <bread>
80102d19:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d1b:	58                   	pop    %eax
80102d1c:	5a                   	pop    %edx
80102d1d:	ff 34 9d 8c 39 11 80 	pushl  -0x7feec674(,%ebx,4)
80102d24:	ff 35 84 39 11 80    	pushl  0x80113984
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d2a:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d2d:	e8 9e d3 ff ff       	call   801000d0 <bread>
80102d32:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102d34:	8d 47 5c             	lea    0x5c(%edi),%eax
80102d37:	83 c4 0c             	add    $0xc,%esp
80102d3a:	68 00 02 00 00       	push   $0x200
80102d3f:	50                   	push   %eax
80102d40:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d43:	50                   	push   %eax
80102d44:	e8 87 1e 00 00       	call   80104bd0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102d49:	89 34 24             	mov    %esi,(%esp)
80102d4c:	e8 4f d4 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102d51:	89 3c 24             	mov    %edi,(%esp)
80102d54:	e8 87 d4 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102d59:	89 34 24             	mov    %esi,(%esp)
80102d5c:	e8 7f d4 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d61:	83 c4 10             	add    $0x10,%esp
80102d64:	39 1d 88 39 11 80    	cmp    %ebx,0x80113988
80102d6a:	7f 94                	jg     80102d00 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102d6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d6f:	5b                   	pop    %ebx
80102d70:	5e                   	pop    %esi
80102d71:	5f                   	pop    %edi
80102d72:	5d                   	pop    %ebp
80102d73:	f3 c3                	repz ret 
80102d75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d80 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	53                   	push   %ebx
80102d84:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102d87:	ff 35 74 39 11 80    	pushl  0x80113974
80102d8d:	ff 35 84 39 11 80    	pushl  0x80113984
80102d93:	e8 38 d3 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102d98:	8b 0d 88 39 11 80    	mov    0x80113988,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102d9e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102da1:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102da3:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102da5:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102da8:	7e 1f                	jle    80102dc9 <write_head+0x49>
80102daa:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102db1:	31 d2                	xor    %edx,%edx
80102db3:	90                   	nop
80102db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102db8:	8b 8a 8c 39 11 80    	mov    -0x7feec674(%edx),%ecx
80102dbe:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102dc2:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102dc5:	39 c2                	cmp    %eax,%edx
80102dc7:	75 ef                	jne    80102db8 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102dc9:	83 ec 0c             	sub    $0xc,%esp
80102dcc:	53                   	push   %ebx
80102dcd:	e8 ce d3 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102dd2:	89 1c 24             	mov    %ebx,(%esp)
80102dd5:	e8 06 d4 ff ff       	call   801001e0 <brelse>
}
80102dda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ddd:	c9                   	leave  
80102dde:	c3                   	ret    
80102ddf:	90                   	nop

80102de0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102de0:	55                   	push   %ebp
80102de1:	89 e5                	mov    %esp,%ebp
80102de3:	53                   	push   %ebx
80102de4:	83 ec 2c             	sub    $0x2c,%esp
80102de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102dea:	68 40 7b 10 80       	push   $0x80107b40
80102def:	68 40 39 11 80       	push   $0x80113940
80102df4:	e8 c7 1a 00 00       	call   801048c0 <initlock>
  readsb(dev, &sb);
80102df9:	58                   	pop    %eax
80102dfa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102dfd:	5a                   	pop    %edx
80102dfe:	50                   	push   %eax
80102dff:	53                   	push   %ebx
80102e00:	e8 db e8 ff ff       	call   801016e0 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102e05:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102e08:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102e0b:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102e0c:	89 1d 84 39 11 80    	mov    %ebx,0x80113984

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102e12:	89 15 78 39 11 80    	mov    %edx,0x80113978
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102e18:	a3 74 39 11 80       	mov    %eax,0x80113974

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102e1d:	5a                   	pop    %edx
80102e1e:	50                   	push   %eax
80102e1f:	53                   	push   %ebx
80102e20:	e8 ab d2 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102e25:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102e28:	83 c4 10             	add    $0x10,%esp
80102e2b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102e2d:	89 0d 88 39 11 80    	mov    %ecx,0x80113988
  for (i = 0; i < log.lh.n; i++) {
80102e33:	7e 1c                	jle    80102e51 <initlog+0x71>
80102e35:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102e3c:	31 d2                	xor    %edx,%edx
80102e3e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102e40:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102e44:	83 c2 04             	add    $0x4,%edx
80102e47:	89 8a 88 39 11 80    	mov    %ecx,-0x7feec678(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102e4d:	39 da                	cmp    %ebx,%edx
80102e4f:	75 ef                	jne    80102e40 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102e51:	83 ec 0c             	sub    $0xc,%esp
80102e54:	50                   	push   %eax
80102e55:	e8 86 d3 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102e5a:	e8 81 fe ff ff       	call   80102ce0 <install_trans>
  log.lh.n = 0;
80102e5f:	c7 05 88 39 11 80 00 	movl   $0x0,0x80113988
80102e66:	00 00 00 
  write_head(); // clear the log
80102e69:	e8 12 ff ff ff       	call   80102d80 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102e6e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e71:	c9                   	leave  
80102e72:	c3                   	ret    
80102e73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e80 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102e80:	55                   	push   %ebp
80102e81:	89 e5                	mov    %esp,%ebp
80102e83:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102e86:	68 40 39 11 80       	push   $0x80113940
80102e8b:	e8 90 1b 00 00       	call   80104a20 <acquire>
80102e90:	83 c4 10             	add    $0x10,%esp
80102e93:	eb 18                	jmp    80102ead <begin_op+0x2d>
80102e95:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102e98:	83 ec 08             	sub    $0x8,%esp
80102e9b:	68 40 39 11 80       	push   $0x80113940
80102ea0:	68 40 39 11 80       	push   $0x80113940
80102ea5:	e8 c6 11 00 00       	call   80104070 <sleep>
80102eaa:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102ead:	a1 80 39 11 80       	mov    0x80113980,%eax
80102eb2:	85 c0                	test   %eax,%eax
80102eb4:	75 e2                	jne    80102e98 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102eb6:	a1 7c 39 11 80       	mov    0x8011397c,%eax
80102ebb:	8b 15 88 39 11 80    	mov    0x80113988,%edx
80102ec1:	83 c0 01             	add    $0x1,%eax
80102ec4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102ec7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102eca:	83 fa 1e             	cmp    $0x1e,%edx
80102ecd:	7f c9                	jg     80102e98 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102ecf:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102ed2:	a3 7c 39 11 80       	mov    %eax,0x8011397c
      release(&log.lock);
80102ed7:	68 40 39 11 80       	push   $0x80113940
80102edc:	e8 ef 1b 00 00       	call   80104ad0 <release>
      break;
    }
  }
}
80102ee1:	83 c4 10             	add    $0x10,%esp
80102ee4:	c9                   	leave  
80102ee5:	c3                   	ret    
80102ee6:	8d 76 00             	lea    0x0(%esi),%esi
80102ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ef0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102ef0:	55                   	push   %ebp
80102ef1:	89 e5                	mov    %esp,%ebp
80102ef3:	57                   	push   %edi
80102ef4:	56                   	push   %esi
80102ef5:	53                   	push   %ebx
80102ef6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ef9:	68 40 39 11 80       	push   $0x80113940
80102efe:	e8 1d 1b 00 00       	call   80104a20 <acquire>
  log.outstanding -= 1;
80102f03:	a1 7c 39 11 80       	mov    0x8011397c,%eax
  if(log.committing)
80102f08:	8b 1d 80 39 11 80    	mov    0x80113980,%ebx
80102f0e:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102f11:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102f14:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102f16:	a3 7c 39 11 80       	mov    %eax,0x8011397c
  if(log.committing)
80102f1b:	0f 85 23 01 00 00    	jne    80103044 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102f21:	85 c0                	test   %eax,%eax
80102f23:	0f 85 f7 00 00 00    	jne    80103020 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102f29:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102f2c:	c7 05 80 39 11 80 01 	movl   $0x1,0x80113980
80102f33:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102f36:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102f38:	68 40 39 11 80       	push   $0x80113940
80102f3d:	e8 8e 1b 00 00       	call   80104ad0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102f42:	8b 0d 88 39 11 80    	mov    0x80113988,%ecx
80102f48:	83 c4 10             	add    $0x10,%esp
80102f4b:	85 c9                	test   %ecx,%ecx
80102f4d:	0f 8e 8a 00 00 00    	jle    80102fdd <end_op+0xed>
80102f53:	90                   	nop
80102f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102f58:	a1 74 39 11 80       	mov    0x80113974,%eax
80102f5d:	83 ec 08             	sub    $0x8,%esp
80102f60:	01 d8                	add    %ebx,%eax
80102f62:	83 c0 01             	add    $0x1,%eax
80102f65:	50                   	push   %eax
80102f66:	ff 35 84 39 11 80    	pushl  0x80113984
80102f6c:	e8 5f d1 ff ff       	call   801000d0 <bread>
80102f71:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f73:	58                   	pop    %eax
80102f74:	5a                   	pop    %edx
80102f75:	ff 34 9d 8c 39 11 80 	pushl  -0x7feec674(,%ebx,4)
80102f7c:	ff 35 84 39 11 80    	pushl  0x80113984
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102f82:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f85:	e8 46 d1 ff ff       	call   801000d0 <bread>
80102f8a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102f8c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102f8f:	83 c4 0c             	add    $0xc,%esp
80102f92:	68 00 02 00 00       	push   $0x200
80102f97:	50                   	push   %eax
80102f98:	8d 46 5c             	lea    0x5c(%esi),%eax
80102f9b:	50                   	push   %eax
80102f9c:	e8 2f 1c 00 00       	call   80104bd0 <memmove>
    bwrite(to);  // write the log
80102fa1:	89 34 24             	mov    %esi,(%esp)
80102fa4:	e8 f7 d1 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102fa9:	89 3c 24             	mov    %edi,(%esp)
80102fac:	e8 2f d2 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102fb1:	89 34 24             	mov    %esi,(%esp)
80102fb4:	e8 27 d2 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102fb9:	83 c4 10             	add    $0x10,%esp
80102fbc:	3b 1d 88 39 11 80    	cmp    0x80113988,%ebx
80102fc2:	7c 94                	jl     80102f58 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102fc4:	e8 b7 fd ff ff       	call   80102d80 <write_head>
    install_trans(); // Now install writes to home locations
80102fc9:	e8 12 fd ff ff       	call   80102ce0 <install_trans>
    log.lh.n = 0;
80102fce:	c7 05 88 39 11 80 00 	movl   $0x0,0x80113988
80102fd5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102fd8:	e8 a3 fd ff ff       	call   80102d80 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102fdd:	83 ec 0c             	sub    $0xc,%esp
80102fe0:	68 40 39 11 80       	push   $0x80113940
80102fe5:	e8 36 1a 00 00       	call   80104a20 <acquire>
    log.committing = 0;
    wakeup(&log);
80102fea:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102ff1:	c7 05 80 39 11 80 00 	movl   $0x0,0x80113980
80102ff8:	00 00 00 
    wakeup(&log);
80102ffb:	e8 30 12 00 00       	call   80104230 <wakeup>
    release(&log.lock);
80103000:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80103007:	e8 c4 1a 00 00       	call   80104ad0 <release>
8010300c:	83 c4 10             	add    $0x10,%esp
  }
}
8010300f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103012:	5b                   	pop    %ebx
80103013:	5e                   	pop    %esi
80103014:	5f                   	pop    %edi
80103015:	5d                   	pop    %ebp
80103016:	c3                   	ret    
80103017:	89 f6                	mov    %esi,%esi
80103019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80103020:	83 ec 0c             	sub    $0xc,%esp
80103023:	68 40 39 11 80       	push   $0x80113940
80103028:	e8 03 12 00 00       	call   80104230 <wakeup>
  }
  release(&log.lock);
8010302d:	c7 04 24 40 39 11 80 	movl   $0x80113940,(%esp)
80103034:	e8 97 1a 00 00       	call   80104ad0 <release>
80103039:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
8010303c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010303f:	5b                   	pop    %ebx
80103040:	5e                   	pop    %esi
80103041:	5f                   	pop    %edi
80103042:	5d                   	pop    %ebp
80103043:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80103044:	83 ec 0c             	sub    $0xc,%esp
80103047:	68 44 7b 10 80       	push   $0x80107b44
8010304c:	e8 1f d3 ff ff       	call   80100370 <panic>
80103051:	eb 0d                	jmp    80103060 <log_write>
80103053:	90                   	nop
80103054:	90                   	nop
80103055:	90                   	nop
80103056:	90                   	nop
80103057:	90                   	nop
80103058:	90                   	nop
80103059:	90                   	nop
8010305a:	90                   	nop
8010305b:	90                   	nop
8010305c:	90                   	nop
8010305d:	90                   	nop
8010305e:	90                   	nop
8010305f:	90                   	nop

80103060 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103060:	55                   	push   %ebp
80103061:	89 e5                	mov    %esp,%ebp
80103063:	53                   	push   %ebx
80103064:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103067:	8b 15 88 39 11 80    	mov    0x80113988,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
8010306d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103070:	83 fa 1d             	cmp    $0x1d,%edx
80103073:	0f 8f 97 00 00 00    	jg     80103110 <log_write+0xb0>
80103079:	a1 78 39 11 80       	mov    0x80113978,%eax
8010307e:	83 e8 01             	sub    $0x1,%eax
80103081:	39 c2                	cmp    %eax,%edx
80103083:	0f 8d 87 00 00 00    	jge    80103110 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103089:	a1 7c 39 11 80       	mov    0x8011397c,%eax
8010308e:	85 c0                	test   %eax,%eax
80103090:	0f 8e 87 00 00 00    	jle    8010311d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103096:	83 ec 0c             	sub    $0xc,%esp
80103099:	68 40 39 11 80       	push   $0x80113940
8010309e:	e8 7d 19 00 00       	call   80104a20 <acquire>
  for (i = 0; i < log.lh.n; i++) {
801030a3:	8b 15 88 39 11 80    	mov    0x80113988,%edx
801030a9:	83 c4 10             	add    $0x10,%esp
801030ac:	83 fa 00             	cmp    $0x0,%edx
801030af:	7e 50                	jle    80103101 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801030b1:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
801030b4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801030b6:	3b 0d 8c 39 11 80    	cmp    0x8011398c,%ecx
801030bc:	75 0b                	jne    801030c9 <log_write+0x69>
801030be:	eb 38                	jmp    801030f8 <log_write+0x98>
801030c0:	39 0c 85 8c 39 11 80 	cmp    %ecx,-0x7feec674(,%eax,4)
801030c7:	74 2f                	je     801030f8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
801030c9:	83 c0 01             	add    $0x1,%eax
801030cc:	39 d0                	cmp    %edx,%eax
801030ce:	75 f0                	jne    801030c0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
801030d0:	89 0c 95 8c 39 11 80 	mov    %ecx,-0x7feec674(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
801030d7:	83 c2 01             	add    $0x1,%edx
801030da:	89 15 88 39 11 80    	mov    %edx,0x80113988
  b->flags |= B_DIRTY; // prevent eviction
801030e0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
801030e3:	c7 45 08 40 39 11 80 	movl   $0x80113940,0x8(%ebp)
}
801030ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030ed:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
801030ee:	e9 dd 19 00 00       	jmp    80104ad0 <release>
801030f3:	90                   	nop
801030f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
801030f8:	89 0c 85 8c 39 11 80 	mov    %ecx,-0x7feec674(,%eax,4)
801030ff:	eb df                	jmp    801030e0 <log_write+0x80>
80103101:	8b 43 08             	mov    0x8(%ebx),%eax
80103104:	a3 8c 39 11 80       	mov    %eax,0x8011398c
  if (i == log.lh.n)
80103109:	75 d5                	jne    801030e0 <log_write+0x80>
8010310b:	eb ca                	jmp    801030d7 <log_write+0x77>
8010310d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80103110:	83 ec 0c             	sub    $0xc,%esp
80103113:	68 53 7b 10 80       	push   $0x80107b53
80103118:	e8 53 d2 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
8010311d:	83 ec 0c             	sub    $0xc,%esp
80103120:	68 69 7b 10 80       	push   $0x80107b69
80103125:	e8 46 d2 ff ff       	call   80100370 <panic>
8010312a:	66 90                	xchg   %ax,%ax
8010312c:	66 90                	xchg   %ax,%ax
8010312e:	66 90                	xchg   %ax,%ax

80103130 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103130:	55                   	push   %ebp
80103131:	89 e5                	mov    %esp,%ebp
80103133:	53                   	push   %ebx
80103134:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103137:	e8 64 09 00 00       	call   80103aa0 <cpuid>
8010313c:	89 c3                	mov    %eax,%ebx
8010313e:	e8 5d 09 00 00       	call   80103aa0 <cpuid>
80103143:	83 ec 04             	sub    $0x4,%esp
80103146:	53                   	push   %ebx
80103147:	50                   	push   %eax
80103148:	68 84 7b 10 80       	push   $0x80107b84
8010314d:	e8 0e d5 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103152:	e8 49 2d 00 00       	call   80105ea0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103157:	e8 c4 08 00 00       	call   80103a20 <mycpu>
8010315c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010315e:	b8 01 00 00 00       	mov    $0x1,%eax
80103163:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010316a:	e8 11 0c 00 00       	call   80103d80 <scheduler>
8010316f:	90                   	nop

80103170 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103170:	55                   	push   %ebp
80103171:	89 e5                	mov    %esp,%ebp
80103173:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103176:	e8 45 3e 00 00       	call   80106fc0 <switchkvm>
  seginit();
8010317b:	e8 40 3d 00 00       	call   80106ec0 <seginit>
  lapicinit();
80103180:	e8 9b f7 ff ff       	call   80102920 <lapicinit>
  mpmain();
80103185:	e8 a6 ff ff ff       	call   80103130 <mpmain>
8010318a:	66 90                	xchg   %ax,%ax
8010318c:	66 90                	xchg   %ax,%ax
8010318e:	66 90                	xchg   %ax,%ax

80103190 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103190:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103194:	83 e4 f0             	and    $0xfffffff0,%esp
80103197:	ff 71 fc             	pushl  -0x4(%ecx)
8010319a:	55                   	push   %ebp
8010319b:	89 e5                	mov    %esp,%ebp
8010319d:	53                   	push   %ebx
8010319e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010319f:	bb 40 3a 11 80       	mov    $0x80113a40,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801031a4:	83 ec 08             	sub    $0x8,%esp
801031a7:	68 00 00 40 80       	push   $0x80400000
801031ac:	68 68 69 11 80       	push   $0x80116968
801031b1:	e8 3a f5 ff ff       	call   801026f0 <kinit1>
  kvmalloc();      // kernel page table
801031b6:	e8 a5 42 00 00       	call   80107460 <kvmalloc>
  mpinit();        // detect other processors
801031bb:	e8 70 01 00 00       	call   80103330 <mpinit>
  lapicinit();     // interrupt controller
801031c0:	e8 5b f7 ff ff       	call   80102920 <lapicinit>
  seginit();       // segment descriptors
801031c5:	e8 f6 3c 00 00       	call   80106ec0 <seginit>
  picinit();       // disable pic
801031ca:	e8 31 03 00 00       	call   80103500 <picinit>
  ioapicinit();    // another interrupt controller
801031cf:	e8 4c f3 ff ff       	call   80102520 <ioapicinit>
  consoleinit();   // console hardware
801031d4:	e8 f7 da ff ff       	call   80100cd0 <consoleinit>
  uartinit();      // serial port
801031d9:	e8 b2 2f 00 00       	call   80106190 <uartinit>
  pinit();         // process table
801031de:	e8 1d 08 00 00       	call   80103a00 <pinit>
  tvinit();        // trap vectors
801031e3:	e8 18 2c 00 00       	call   80105e00 <tvinit>
  binit();         // buffer cache
801031e8:	e8 53 ce ff ff       	call   80100040 <binit>
  fileinit();      // file table
801031ed:	e8 8e de ff ff       	call   80101080 <fileinit>
  ideinit();       // disk 
801031f2:	e8 09 f1 ff ff       	call   80102300 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801031f7:	83 c4 0c             	add    $0xc,%esp
801031fa:	68 8a 00 00 00       	push   $0x8a
801031ff:	68 8c b4 10 80       	push   $0x8010b48c
80103204:	68 00 70 00 80       	push   $0x80007000
80103209:	e8 c2 19 00 00       	call   80104bd0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010320e:	69 05 c0 3f 11 80 b0 	imul   $0xb0,0x80113fc0,%eax
80103215:	00 00 00 
80103218:	83 c4 10             	add    $0x10,%esp
8010321b:	05 40 3a 11 80       	add    $0x80113a40,%eax
80103220:	39 d8                	cmp    %ebx,%eax
80103222:	76 6f                	jbe    80103293 <main+0x103>
80103224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80103228:	e8 f3 07 00 00       	call   80103a20 <mycpu>
8010322d:	39 d8                	cmp    %ebx,%eax
8010322f:	74 49                	je     8010327a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103231:	e8 8a f5 ff ff       	call   801027c0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80103236:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
8010323b:	c7 05 f8 6f 00 80 70 	movl   $0x80103170,0x80006ff8
80103242:	31 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103245:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010324c:	a0 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010324f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103254:	0f b6 03             	movzbl (%ebx),%eax
80103257:	83 ec 08             	sub    $0x8,%esp
8010325a:	68 00 70 00 00       	push   $0x7000
8010325f:	50                   	push   %eax
80103260:	e8 0b f8 ff ff       	call   80102a70 <lapicstartap>
80103265:	83 c4 10             	add    $0x10,%esp
80103268:	90                   	nop
80103269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103270:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103276:	85 c0                	test   %eax,%eax
80103278:	74 f6                	je     80103270 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010327a:	69 05 c0 3f 11 80 b0 	imul   $0xb0,0x80113fc0,%eax
80103281:	00 00 00 
80103284:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010328a:	05 40 3a 11 80       	add    $0x80113a40,%eax
8010328f:	39 c3                	cmp    %eax,%ebx
80103291:	72 95                	jb     80103228 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103293:	83 ec 08             	sub    $0x8,%esp
80103296:	68 00 00 00 8e       	push   $0x8e000000
8010329b:	68 00 00 40 80       	push   $0x80400000
801032a0:	e8 bb f4 ff ff       	call   80102760 <kinit2>
  userinit();      // first user process
801032a5:	e8 46 08 00 00       	call   80103af0 <userinit>
  mpmain();        // finish this processor's setup
801032aa:	e8 81 fe ff ff       	call   80103130 <mpmain>
801032af:	90                   	nop

801032b0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801032b0:	55                   	push   %ebp
801032b1:	89 e5                	mov    %esp,%ebp
801032b3:	57                   	push   %edi
801032b4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801032b5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801032bb:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
801032bc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801032bf:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801032c2:	39 de                	cmp    %ebx,%esi
801032c4:	73 48                	jae    8010330e <mpsearch1+0x5e>
801032c6:	8d 76 00             	lea    0x0(%esi),%esi
801032c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801032d0:	83 ec 04             	sub    $0x4,%esp
801032d3:	8d 7e 10             	lea    0x10(%esi),%edi
801032d6:	6a 04                	push   $0x4
801032d8:	68 98 7b 10 80       	push   $0x80107b98
801032dd:	56                   	push   %esi
801032de:	e8 8d 18 00 00       	call   80104b70 <memcmp>
801032e3:	83 c4 10             	add    $0x10,%esp
801032e6:	85 c0                	test   %eax,%eax
801032e8:	75 1e                	jne    80103308 <mpsearch1+0x58>
801032ea:	8d 7e 10             	lea    0x10(%esi),%edi
801032ed:	89 f2                	mov    %esi,%edx
801032ef:	31 c9                	xor    %ecx,%ecx
801032f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801032f8:	0f b6 02             	movzbl (%edx),%eax
801032fb:	83 c2 01             	add    $0x1,%edx
801032fe:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103300:	39 fa                	cmp    %edi,%edx
80103302:	75 f4                	jne    801032f8 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103304:	84 c9                	test   %cl,%cl
80103306:	74 10                	je     80103318 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103308:	39 fb                	cmp    %edi,%ebx
8010330a:	89 fe                	mov    %edi,%esi
8010330c:	77 c2                	ja     801032d0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
8010330e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103311:	31 c0                	xor    %eax,%eax
}
80103313:	5b                   	pop    %ebx
80103314:	5e                   	pop    %esi
80103315:	5f                   	pop    %edi
80103316:	5d                   	pop    %ebp
80103317:	c3                   	ret    
80103318:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010331b:	89 f0                	mov    %esi,%eax
8010331d:	5b                   	pop    %ebx
8010331e:	5e                   	pop    %esi
8010331f:	5f                   	pop    %edi
80103320:	5d                   	pop    %ebp
80103321:	c3                   	ret    
80103322:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103330 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103330:	55                   	push   %ebp
80103331:	89 e5                	mov    %esp,%ebp
80103333:	57                   	push   %edi
80103334:	56                   	push   %esi
80103335:	53                   	push   %ebx
80103336:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103339:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103340:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103347:	c1 e0 08             	shl    $0x8,%eax
8010334a:	09 d0                	or     %edx,%eax
8010334c:	c1 e0 04             	shl    $0x4,%eax
8010334f:	85 c0                	test   %eax,%eax
80103351:	75 1b                	jne    8010336e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103353:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010335a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103361:	c1 e0 08             	shl    $0x8,%eax
80103364:	09 d0                	or     %edx,%eax
80103366:	c1 e0 0a             	shl    $0xa,%eax
80103369:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010336e:	ba 00 04 00 00       	mov    $0x400,%edx
80103373:	e8 38 ff ff ff       	call   801032b0 <mpsearch1>
80103378:	85 c0                	test   %eax,%eax
8010337a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010337d:	0f 84 37 01 00 00    	je     801034ba <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103383:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103386:	8b 58 04             	mov    0x4(%eax),%ebx
80103389:	85 db                	test   %ebx,%ebx
8010338b:	0f 84 43 01 00 00    	je     801034d4 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103391:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103397:	83 ec 04             	sub    $0x4,%esp
8010339a:	6a 04                	push   $0x4
8010339c:	68 9d 7b 10 80       	push   $0x80107b9d
801033a1:	56                   	push   %esi
801033a2:	e8 c9 17 00 00       	call   80104b70 <memcmp>
801033a7:	83 c4 10             	add    $0x10,%esp
801033aa:	85 c0                	test   %eax,%eax
801033ac:	0f 85 22 01 00 00    	jne    801034d4 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801033b2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801033b9:	3c 01                	cmp    $0x1,%al
801033bb:	74 08                	je     801033c5 <mpinit+0x95>
801033bd:	3c 04                	cmp    $0x4,%al
801033bf:	0f 85 0f 01 00 00    	jne    801034d4 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801033c5:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801033cc:	85 ff                	test   %edi,%edi
801033ce:	74 21                	je     801033f1 <mpinit+0xc1>
801033d0:	31 d2                	xor    %edx,%edx
801033d2:	31 c0                	xor    %eax,%eax
801033d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801033d8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801033df:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801033e0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801033e3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801033e5:	39 c7                	cmp    %eax,%edi
801033e7:	75 ef                	jne    801033d8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801033e9:	84 d2                	test   %dl,%dl
801033eb:	0f 85 e3 00 00 00    	jne    801034d4 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801033f1:	85 f6                	test   %esi,%esi
801033f3:	0f 84 db 00 00 00    	je     801034d4 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801033f9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801033ff:	a3 3c 39 11 80       	mov    %eax,0x8011393c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103404:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
8010340b:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80103411:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103416:	01 d6                	add    %edx,%esi
80103418:	90                   	nop
80103419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103420:	39 c6                	cmp    %eax,%esi
80103422:	76 23                	jbe    80103447 <mpinit+0x117>
80103424:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80103427:	80 fa 04             	cmp    $0x4,%dl
8010342a:	0f 87 c0 00 00 00    	ja     801034f0 <mpinit+0x1c0>
80103430:	ff 24 95 dc 7b 10 80 	jmp    *-0x7fef8424(,%edx,4)
80103437:	89 f6                	mov    %esi,%esi
80103439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103440:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103443:	39 c6                	cmp    %eax,%esi
80103445:	77 dd                	ja     80103424 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103447:	85 db                	test   %ebx,%ebx
80103449:	0f 84 92 00 00 00    	je     801034e1 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010344f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103452:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103456:	74 15                	je     8010346d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103458:	ba 22 00 00 00       	mov    $0x22,%edx
8010345d:	b8 70 00 00 00       	mov    $0x70,%eax
80103462:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103463:	ba 23 00 00 00       	mov    $0x23,%edx
80103468:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103469:	83 c8 01             	or     $0x1,%eax
8010346c:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010346d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103470:	5b                   	pop    %ebx
80103471:	5e                   	pop    %esi
80103472:	5f                   	pop    %edi
80103473:	5d                   	pop    %ebp
80103474:	c3                   	ret    
80103475:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103478:	8b 0d c0 3f 11 80    	mov    0x80113fc0,%ecx
8010347e:	83 f9 07             	cmp    $0x7,%ecx
80103481:	7f 19                	jg     8010349c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103483:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103487:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010348d:	83 c1 01             	add    $0x1,%ecx
80103490:	89 0d c0 3f 11 80    	mov    %ecx,0x80113fc0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103496:	88 97 40 3a 11 80    	mov    %dl,-0x7feec5c0(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010349c:	83 c0 14             	add    $0x14,%eax
      continue;
8010349f:	e9 7c ff ff ff       	jmp    80103420 <mpinit+0xf0>
801034a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801034a8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801034ac:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801034af:	88 15 20 3a 11 80    	mov    %dl,0x80113a20
      p += sizeof(struct mpioapic);
      continue;
801034b5:	e9 66 ff ff ff       	jmp    80103420 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801034ba:	ba 00 00 01 00       	mov    $0x10000,%edx
801034bf:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801034c4:	e8 e7 fd ff ff       	call   801032b0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801034c9:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801034cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801034ce:	0f 85 af fe ff ff    	jne    80103383 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
801034d4:	83 ec 0c             	sub    $0xc,%esp
801034d7:	68 a2 7b 10 80       	push   $0x80107ba2
801034dc:	e8 8f ce ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801034e1:	83 ec 0c             	sub    $0xc,%esp
801034e4:	68 bc 7b 10 80       	push   $0x80107bbc
801034e9:	e8 82 ce ff ff       	call   80100370 <panic>
801034ee:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801034f0:	31 db                	xor    %ebx,%ebx
801034f2:	e9 30 ff ff ff       	jmp    80103427 <mpinit+0xf7>
801034f7:	66 90                	xchg   %ax,%ax
801034f9:	66 90                	xchg   %ax,%ax
801034fb:	66 90                	xchg   %ax,%ax
801034fd:	66 90                	xchg   %ax,%ax
801034ff:	90                   	nop

80103500 <picinit>:
80103500:	55                   	push   %ebp
80103501:	ba 21 00 00 00       	mov    $0x21,%edx
80103506:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010350b:	89 e5                	mov    %esp,%ebp
8010350d:	ee                   	out    %al,(%dx)
8010350e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103513:	ee                   	out    %al,(%dx)
80103514:	5d                   	pop    %ebp
80103515:	c3                   	ret    
80103516:	66 90                	xchg   %ax,%ax
80103518:	66 90                	xchg   %ax,%ax
8010351a:	66 90                	xchg   %ax,%ax
8010351c:	66 90                	xchg   %ax,%ax
8010351e:	66 90                	xchg   %ax,%ax

80103520 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103520:	55                   	push   %ebp
80103521:	89 e5                	mov    %esp,%ebp
80103523:	57                   	push   %edi
80103524:	56                   	push   %esi
80103525:	53                   	push   %ebx
80103526:	83 ec 0c             	sub    $0xc,%esp
80103529:	8b 75 08             	mov    0x8(%ebp),%esi
8010352c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010352f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103535:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010353b:	e8 60 db ff ff       	call   801010a0 <filealloc>
80103540:	85 c0                	test   %eax,%eax
80103542:	89 06                	mov    %eax,(%esi)
80103544:	0f 84 a8 00 00 00    	je     801035f2 <pipealloc+0xd2>
8010354a:	e8 51 db ff ff       	call   801010a0 <filealloc>
8010354f:	85 c0                	test   %eax,%eax
80103551:	89 03                	mov    %eax,(%ebx)
80103553:	0f 84 87 00 00 00    	je     801035e0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103559:	e8 62 f2 ff ff       	call   801027c0 <kalloc>
8010355e:	85 c0                	test   %eax,%eax
80103560:	89 c7                	mov    %eax,%edi
80103562:	0f 84 b0 00 00 00    	je     80103618 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103568:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010356b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103572:	00 00 00 
  p->writeopen = 1;
80103575:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010357c:	00 00 00 
  p->nwrite = 0;
8010357f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103586:	00 00 00 
  p->nread = 0;
80103589:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103590:	00 00 00 
  initlock(&p->lock, "pipe");
80103593:	68 f0 7b 10 80       	push   $0x80107bf0
80103598:	50                   	push   %eax
80103599:	e8 22 13 00 00       	call   801048c0 <initlock>
  (*f0)->type = FD_PIPE;
8010359e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801035a0:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
801035a3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801035a9:	8b 06                	mov    (%esi),%eax
801035ab:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801035af:	8b 06                	mov    (%esi),%eax
801035b1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801035b5:	8b 06                	mov    (%esi),%eax
801035b7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801035ba:	8b 03                	mov    (%ebx),%eax
801035bc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801035c2:	8b 03                	mov    (%ebx),%eax
801035c4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801035c8:	8b 03                	mov    (%ebx),%eax
801035ca:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801035ce:	8b 03                	mov    (%ebx),%eax
801035d0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801035d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801035d6:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801035d8:	5b                   	pop    %ebx
801035d9:	5e                   	pop    %esi
801035da:	5f                   	pop    %edi
801035db:	5d                   	pop    %ebp
801035dc:	c3                   	ret    
801035dd:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801035e0:	8b 06                	mov    (%esi),%eax
801035e2:	85 c0                	test   %eax,%eax
801035e4:	74 1e                	je     80103604 <pipealloc+0xe4>
    fileclose(*f0);
801035e6:	83 ec 0c             	sub    $0xc,%esp
801035e9:	50                   	push   %eax
801035ea:	e8 71 db ff ff       	call   80101160 <fileclose>
801035ef:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801035f2:	8b 03                	mov    (%ebx),%eax
801035f4:	85 c0                	test   %eax,%eax
801035f6:	74 0c                	je     80103604 <pipealloc+0xe4>
    fileclose(*f1);
801035f8:	83 ec 0c             	sub    $0xc,%esp
801035fb:	50                   	push   %eax
801035fc:	e8 5f db ff ff       	call   80101160 <fileclose>
80103601:	83 c4 10             	add    $0x10,%esp
  return -1;
}
80103604:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
80103607:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010360c:	5b                   	pop    %ebx
8010360d:	5e                   	pop    %esi
8010360e:	5f                   	pop    %edi
8010360f:	5d                   	pop    %ebp
80103610:	c3                   	ret    
80103611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103618:	8b 06                	mov    (%esi),%eax
8010361a:	85 c0                	test   %eax,%eax
8010361c:	75 c8                	jne    801035e6 <pipealloc+0xc6>
8010361e:	eb d2                	jmp    801035f2 <pipealloc+0xd2>

80103620 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103620:	55                   	push   %ebp
80103621:	89 e5                	mov    %esp,%ebp
80103623:	56                   	push   %esi
80103624:	53                   	push   %ebx
80103625:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103628:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010362b:	83 ec 0c             	sub    $0xc,%esp
8010362e:	53                   	push   %ebx
8010362f:	e8 ec 13 00 00       	call   80104a20 <acquire>
  if(writable){
80103634:	83 c4 10             	add    $0x10,%esp
80103637:	85 f6                	test   %esi,%esi
80103639:	74 45                	je     80103680 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010363b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103641:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103644:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010364b:	00 00 00 
    wakeup(&p->nread);
8010364e:	50                   	push   %eax
8010364f:	e8 dc 0b 00 00       	call   80104230 <wakeup>
80103654:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103657:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010365d:	85 d2                	test   %edx,%edx
8010365f:	75 0a                	jne    8010366b <pipeclose+0x4b>
80103661:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103667:	85 c0                	test   %eax,%eax
80103669:	74 35                	je     801036a0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010366b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010366e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103671:	5b                   	pop    %ebx
80103672:	5e                   	pop    %esi
80103673:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103674:	e9 57 14 00 00       	jmp    80104ad0 <release>
80103679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103680:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103686:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103689:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103690:	00 00 00 
    wakeup(&p->nwrite);
80103693:	50                   	push   %eax
80103694:	e8 97 0b 00 00       	call   80104230 <wakeup>
80103699:	83 c4 10             	add    $0x10,%esp
8010369c:	eb b9                	jmp    80103657 <pipeclose+0x37>
8010369e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
801036a0:	83 ec 0c             	sub    $0xc,%esp
801036a3:	53                   	push   %ebx
801036a4:	e8 27 14 00 00       	call   80104ad0 <release>
    kfree((char*)p);
801036a9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801036ac:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
801036af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801036b2:	5b                   	pop    %ebx
801036b3:	5e                   	pop    %esi
801036b4:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801036b5:	e9 56 ef ff ff       	jmp    80102610 <kfree>
801036ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801036c0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	57                   	push   %edi
801036c4:	56                   	push   %esi
801036c5:	53                   	push   %ebx
801036c6:	83 ec 28             	sub    $0x28,%esp
801036c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801036cc:	53                   	push   %ebx
801036cd:	e8 4e 13 00 00       	call   80104a20 <acquire>
  for(i = 0; i < n; i++){
801036d2:	8b 45 10             	mov    0x10(%ebp),%eax
801036d5:	83 c4 10             	add    $0x10,%esp
801036d8:	85 c0                	test   %eax,%eax
801036da:	0f 8e b9 00 00 00    	jle    80103799 <pipewrite+0xd9>
801036e0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801036e3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801036e9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801036ef:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801036f5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801036f8:	03 4d 10             	add    0x10(%ebp),%ecx
801036fb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036fe:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103704:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
8010370a:	39 d0                	cmp    %edx,%eax
8010370c:	74 38                	je     80103746 <pipewrite+0x86>
8010370e:	eb 59                	jmp    80103769 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
80103710:	e8 ab 03 00 00       	call   80103ac0 <myproc>
80103715:	8b 48 24             	mov    0x24(%eax),%ecx
80103718:	85 c9                	test   %ecx,%ecx
8010371a:	75 34                	jne    80103750 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010371c:	83 ec 0c             	sub    $0xc,%esp
8010371f:	57                   	push   %edi
80103720:	e8 0b 0b 00 00       	call   80104230 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103725:	58                   	pop    %eax
80103726:	5a                   	pop    %edx
80103727:	53                   	push   %ebx
80103728:	56                   	push   %esi
80103729:	e8 42 09 00 00       	call   80104070 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010372e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103734:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010373a:	83 c4 10             	add    $0x10,%esp
8010373d:	05 00 02 00 00       	add    $0x200,%eax
80103742:	39 c2                	cmp    %eax,%edx
80103744:	75 2a                	jne    80103770 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80103746:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010374c:	85 c0                	test   %eax,%eax
8010374e:	75 c0                	jne    80103710 <pipewrite+0x50>
        release(&p->lock);
80103750:	83 ec 0c             	sub    $0xc,%esp
80103753:	53                   	push   %ebx
80103754:	e8 77 13 00 00       	call   80104ad0 <release>
        return -1;
80103759:	83 c4 10             	add    $0x10,%esp
8010375c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103761:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103764:	5b                   	pop    %ebx
80103765:	5e                   	pop    %esi
80103766:	5f                   	pop    %edi
80103767:	5d                   	pop    %ebp
80103768:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103769:	89 c2                	mov    %eax,%edx
8010376b:	90                   	nop
8010376c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103770:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103773:	8d 42 01             	lea    0x1(%edx),%eax
80103776:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010377a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103780:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103786:	0f b6 09             	movzbl (%ecx),%ecx
80103789:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010378d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103790:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103793:	0f 85 65 ff ff ff    	jne    801036fe <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103799:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010379f:	83 ec 0c             	sub    $0xc,%esp
801037a2:	50                   	push   %eax
801037a3:	e8 88 0a 00 00       	call   80104230 <wakeup>
  release(&p->lock);
801037a8:	89 1c 24             	mov    %ebx,(%esp)
801037ab:	e8 20 13 00 00       	call   80104ad0 <release>
  return n;
801037b0:	83 c4 10             	add    $0x10,%esp
801037b3:	8b 45 10             	mov    0x10(%ebp),%eax
801037b6:	eb a9                	jmp    80103761 <pipewrite+0xa1>
801037b8:	90                   	nop
801037b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801037c0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	57                   	push   %edi
801037c4:	56                   	push   %esi
801037c5:	53                   	push   %ebx
801037c6:	83 ec 18             	sub    $0x18,%esp
801037c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801037cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801037cf:	53                   	push   %ebx
801037d0:	e8 4b 12 00 00       	call   80104a20 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801037d5:	83 c4 10             	add    $0x10,%esp
801037d8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801037de:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801037e4:	75 6a                	jne    80103850 <piperead+0x90>
801037e6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801037ec:	85 f6                	test   %esi,%esi
801037ee:	0f 84 cc 00 00 00    	je     801038c0 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801037f4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801037fa:	eb 2d                	jmp    80103829 <piperead+0x69>
801037fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103800:	83 ec 08             	sub    $0x8,%esp
80103803:	53                   	push   %ebx
80103804:	56                   	push   %esi
80103805:	e8 66 08 00 00       	call   80104070 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010380a:	83 c4 10             	add    $0x10,%esp
8010380d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103813:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103819:	75 35                	jne    80103850 <piperead+0x90>
8010381b:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103821:	85 d2                	test   %edx,%edx
80103823:	0f 84 97 00 00 00    	je     801038c0 <piperead+0x100>
    if(myproc()->killed){
80103829:	e8 92 02 00 00       	call   80103ac0 <myproc>
8010382e:	8b 48 24             	mov    0x24(%eax),%ecx
80103831:	85 c9                	test   %ecx,%ecx
80103833:	74 cb                	je     80103800 <piperead+0x40>
      release(&p->lock);
80103835:	83 ec 0c             	sub    $0xc,%esp
80103838:	53                   	push   %ebx
80103839:	e8 92 12 00 00       	call   80104ad0 <release>
      return -1;
8010383e:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103841:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103844:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103849:	5b                   	pop    %ebx
8010384a:	5e                   	pop    %esi
8010384b:	5f                   	pop    %edi
8010384c:	5d                   	pop    %ebp
8010384d:	c3                   	ret    
8010384e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103850:	8b 45 10             	mov    0x10(%ebp),%eax
80103853:	85 c0                	test   %eax,%eax
80103855:	7e 69                	jle    801038c0 <piperead+0x100>
    if(p->nread == p->nwrite)
80103857:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010385d:	31 c9                	xor    %ecx,%ecx
8010385f:	eb 15                	jmp    80103876 <piperead+0xb6>
80103861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103868:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010386e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103874:	74 5a                	je     801038d0 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103876:	8d 70 01             	lea    0x1(%eax),%esi
80103879:	25 ff 01 00 00       	and    $0x1ff,%eax
8010387e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103884:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103889:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010388c:	83 c1 01             	add    $0x1,%ecx
8010388f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103892:	75 d4                	jne    80103868 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103894:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010389a:	83 ec 0c             	sub    $0xc,%esp
8010389d:	50                   	push   %eax
8010389e:	e8 8d 09 00 00       	call   80104230 <wakeup>
  release(&p->lock);
801038a3:	89 1c 24             	mov    %ebx,(%esp)
801038a6:	e8 25 12 00 00       	call   80104ad0 <release>
  return i;
801038ab:	8b 45 10             	mov    0x10(%ebp),%eax
801038ae:	83 c4 10             	add    $0x10,%esp
}
801038b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038b4:	5b                   	pop    %ebx
801038b5:	5e                   	pop    %esi
801038b6:	5f                   	pop    %edi
801038b7:	5d                   	pop    %ebp
801038b8:	c3                   	ret    
801038b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801038c0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801038c7:	eb cb                	jmp    80103894 <piperead+0xd4>
801038c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038d0:	89 4d 10             	mov    %ecx,0x10(%ebp)
801038d3:	eb bf                	jmp    80103894 <piperead+0xd4>
801038d5:	66 90                	xchg   %ax,%ax
801038d7:	66 90                	xchg   %ax,%ax
801038d9:	66 90                	xchg   %ax,%ax
801038db:	66 90                	xchg   %ax,%ax
801038dd:	66 90                	xchg   %ax,%ax
801038df:	90                   	nop

801038e0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc *
allocproc(void)
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801038e4:	bb 14 40 11 80       	mov    $0x80114014,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc *
allocproc(void)
{
801038e9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801038ec:	68 e0 3f 11 80       	push   $0x80113fe0
801038f1:	e8 2a 11 00 00       	call   80104a20 <acquire>
801038f6:	83 c4 10             	add    $0x10,%esp
801038f9:	eb 13                	jmp    8010390e <allocproc+0x2e>
801038fb:	90                   	nop
801038fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103900:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103906:	81 fb 14 61 11 80    	cmp    $0x80116114,%ebx
8010390c:	74 7a                	je     80103988 <allocproc+0xa8>
    if (p->state == UNUSED)
8010390e:	8b 43 0c             	mov    0xc(%ebx),%eax
80103911:	85 c0                	test   %eax,%eax
80103913:	75 eb                	jne    80103900 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103915:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
8010391a:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010391d:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
80103924:	68 e0 3f 11 80       	push   $0x80113fe0
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103929:	8d 50 01             	lea    0x1(%eax),%edx
8010392c:	89 43 10             	mov    %eax,0x10(%ebx)
8010392f:	89 15 04 b0 10 80    	mov    %edx,0x8010b004

  release(&ptable.lock);
80103935:	e8 96 11 00 00       	call   80104ad0 <release>

  // Allocate kernel stack.
  if ((p->kstack = kalloc()) == 0)
8010393a:	e8 81 ee ff ff       	call   801027c0 <kalloc>
8010393f:	83 c4 10             	add    $0x10,%esp
80103942:	85 c0                	test   %eax,%eax
80103944:	89 43 08             	mov    %eax,0x8(%ebx)
80103947:	74 56                	je     8010399f <allocproc+0xbf>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103949:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
8010394f:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
80103952:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103957:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe *)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint *)sp = (uint)trapret;
8010395a:	c7 40 14 ea 5d 10 80 	movl   $0x80105dea,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
80103961:	6a 14                	push   $0x14
80103963:	6a 00                	push   $0x0
80103965:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
80103966:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103969:	e8 b2 11 00 00       	call   80104b20 <memset>
  p->context->eip = (uint)forkret;
8010396e:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103971:	83 c4 10             	add    $0x10,%esp
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103974:	c7 40 10 b0 39 10 80 	movl   $0x801039b0,0x10(%eax)

  return p;
8010397b:	89 d8                	mov    %ebx,%eax
}
8010397d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103980:	c9                   	leave  
80103981:	c3                   	ret    
80103982:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if (p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103988:	83 ec 0c             	sub    $0xc,%esp
8010398b:	68 e0 3f 11 80       	push   $0x80113fe0
80103990:	e8 3b 11 00 00       	call   80104ad0 <release>
  return 0;
80103995:	83 c4 10             	add    $0x10,%esp
80103998:	31 c0                	xor    %eax,%eax
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
8010399a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010399d:	c9                   	leave  
8010399e:	c3                   	ret    
  release(&ptable.lock);

  // Allocate kernel stack.
  if ((p->kstack = kalloc()) == 0)
  {
    p->state = UNUSED;
8010399f:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801039a6:	eb d5                	jmp    8010397d <allocproc+0x9d>
801039a8:	90                   	nop
801039a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801039b0 <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801039b6:	68 e0 3f 11 80       	push   $0x80113fe0
801039bb:	e8 10 11 00 00       	call   80104ad0 <release>

  if (first)
801039c0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801039c5:	83 c4 10             	add    $0x10,%esp
801039c8:	85 c0                	test   %eax,%eax
801039ca:	75 04                	jne    801039d0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801039cc:	c9                   	leave  
801039cd:	c3                   	ret    
801039ce:	66 90                	xchg   %ax,%ax
  {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801039d0:	83 ec 0c             	sub    $0xc,%esp
  if (first)
  {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801039d3:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801039da:	00 00 00 
    iinit(ROOTDEV);
801039dd:	6a 01                	push   $0x1
801039df:	e8 bc dd ff ff       	call   801017a0 <iinit>
    initlog(ROOTDEV);
801039e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801039eb:	e8 f0 f3 ff ff       	call   80102de0 <initlog>
801039f0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801039f3:	c9                   	leave  
801039f4:	c3                   	ret    
801039f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a00 <pinit>:
extern void trapret(void);

static void wakeup1(void *chan);

void pinit(void)
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103a06:	68 f5 7b 10 80       	push   $0x80107bf5
80103a0b:	68 e0 3f 11 80       	push   $0x80113fe0
80103a10:	e8 ab 0e 00 00       	call   801048c0 <initlock>
}
80103a15:	83 c4 10             	add    $0x10,%esp
80103a18:	c9                   	leave  
80103a19:	c3                   	ret    
80103a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a20 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu *
mycpu(void)
{
80103a20:	55                   	push   %ebp
80103a21:	89 e5                	mov    %esp,%ebp
80103a23:	56                   	push   %esi
80103a24:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103a25:	9c                   	pushf  
80103a26:	58                   	pop    %eax
  int apicid, i;

  if (readeflags() & FL_IF)
80103a27:	f6 c4 02             	test   $0x2,%ah
80103a2a:	75 5b                	jne    80103a87 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");

  apicid = lapicid();
80103a2c:	e8 ef ef ff ff       	call   80102a20 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i)
80103a31:	8b 35 c0 3f 11 80    	mov    0x80113fc0,%esi
80103a37:	85 f6                	test   %esi,%esi
80103a39:	7e 3f                	jle    80103a7a <mycpu+0x5a>
  {
    if (cpus[i].apicid == apicid)
80103a3b:	0f b6 15 40 3a 11 80 	movzbl 0x80113a40,%edx
80103a42:	39 d0                	cmp    %edx,%eax
80103a44:	74 30                	je     80103a76 <mycpu+0x56>
80103a46:	b9 f0 3a 11 80       	mov    $0x80113af0,%ecx
80103a4b:	31 d2                	xor    %edx,%edx
80103a4d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");

  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i)
80103a50:	83 c2 01             	add    $0x1,%edx
80103a53:	39 f2                	cmp    %esi,%edx
80103a55:	74 23                	je     80103a7a <mycpu+0x5a>
  {
    if (cpus[i].apicid == apicid)
80103a57:	0f b6 19             	movzbl (%ecx),%ebx
80103a5a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103a60:	39 d8                	cmp    %ebx,%eax
80103a62:	75 ec                	jne    80103a50 <mycpu+0x30>
      return &cpus[i];
80103a64:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
80103a6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a6d:	5b                   	pop    %ebx
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i)
  {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
80103a6e:	05 40 3a 11 80       	add    $0x80113a40,%eax
  }
  panic("unknown apicid\n");
}
80103a73:	5e                   	pop    %esi
80103a74:	5d                   	pop    %ebp
80103a75:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");

  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i)
80103a76:	31 d2                	xor    %edx,%edx
80103a78:	eb ea                	jmp    80103a64 <mycpu+0x44>
  {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
80103a7a:	83 ec 0c             	sub    $0xc,%esp
80103a7d:	68 fc 7b 10 80       	push   $0x80107bfc
80103a82:	e8 e9 c8 ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;

  if (readeflags() & FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103a87:	83 ec 0c             	sub    $0xc,%esp
80103a8a:	68 c4 7d 10 80       	push   $0x80107dc4
80103a8f:	e8 dc c8 ff ff       	call   80100370 <panic>
80103a94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103a9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103aa0 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int cpuid()
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	83 ec 08             	sub    $0x8,%esp
  return mycpu() - cpus;
80103aa6:	e8 75 ff ff ff       	call   80103a20 <mycpu>
80103aab:	2d 40 3a 11 80       	sub    $0x80113a40,%eax
}
80103ab0:	c9                   	leave  
}

// Must be called with interrupts disabled
int cpuid()
{
  return mycpu() - cpus;
80103ab1:	c1 f8 04             	sar    $0x4,%eax
80103ab4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103aba:	c3                   	ret    
80103abb:	90                   	nop
80103abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ac0 <myproc>:

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc *
myproc(void)
{
80103ac0:	55                   	push   %ebp
80103ac1:	89 e5                	mov    %esp,%ebp
80103ac3:	53                   	push   %ebx
80103ac4:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ac7:	e8 74 0e 00 00       	call   80104940 <pushcli>
  c = mycpu();
80103acc:	e8 4f ff ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80103ad1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ad7:	e8 a4 0e 00 00       	call   80104980 <popcli>
  return p;
}
80103adc:	83 c4 04             	add    $0x4,%esp
80103adf:	89 d8                	mov    %ebx,%eax
80103ae1:	5b                   	pop    %ebx
80103ae2:	5d                   	pop    %ebp
80103ae3:	c3                   	ret    
80103ae4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103aea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103af0 <userinit>:
}

//PAGEBREAK: 32
// Set up first user process.
void userinit(void)
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	53                   	push   %ebx
80103af4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103af7:	e8 e4 fd ff ff       	call   801038e0 <allocproc>
80103afc:	89 c3                	mov    %eax,%ebx

  initproc = p;
80103afe:	a3 f8 b5 10 80       	mov    %eax,0x8010b5f8
  if ((p->pgdir = setupkvm()) == 0)
80103b03:	e8 d8 38 00 00       	call   801073e0 <setupkvm>
80103b08:	85 c0                	test   %eax,%eax
80103b0a:	89 43 04             	mov    %eax,0x4(%ebx)
80103b0d:	0f 84 bd 00 00 00    	je     80103bd0 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b13:	83 ec 04             	sub    $0x4,%esp
80103b16:	68 2c 00 00 00       	push   $0x2c
80103b1b:	68 60 b4 10 80       	push   $0x8010b460
80103b20:	50                   	push   %eax
80103b21:	e8 ca 35 00 00       	call   801070f0 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103b26:	83 c4 0c             	add    $0xc,%esp

  initproc = p;
  if ((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103b29:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103b2f:	6a 4c                	push   $0x4c
80103b31:	6a 00                	push   $0x0
80103b33:	ff 73 18             	pushl  0x18(%ebx)
80103b36:	e8 e5 0f 00 00       	call   80104b20 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b3b:	8b 43 18             	mov    0x18(%ebx),%eax
80103b3e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b43:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0; // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b48:	83 c4 0c             	add    $0xc,%esp
  if ((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b4b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b4f:	8b 43 18             	mov    0x18(%ebx),%eax
80103b52:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103b56:	8b 43 18             	mov    0x18(%ebx),%eax
80103b59:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b5d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103b61:	8b 43 18             	mov    0x18(%ebx),%eax
80103b64:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b68:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103b6c:	8b 43 18             	mov    0x18(%ebx),%eax
80103b6f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103b76:	8b 43 18             	mov    0x18(%ebx),%eax
80103b79:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0; // beginning of initcode.S
80103b80:	8b 43 18             	mov    0x18(%ebx),%eax
80103b83:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b8a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b8d:	6a 10                	push   $0x10
80103b8f:	68 25 7c 10 80       	push   $0x80107c25
80103b94:	50                   	push   %eax
80103b95:	e8 86 11 00 00       	call   80104d20 <safestrcpy>
  p->cwd = namei("/");
80103b9a:	c7 04 24 2e 7c 10 80 	movl   $0x80107c2e,(%esp)
80103ba1:	e8 4a e6 ff ff       	call   801021f0 <namei>
80103ba6:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103ba9:	c7 04 24 e0 3f 11 80 	movl   $0x80113fe0,(%esp)
80103bb0:	e8 6b 0e 00 00       	call   80104a20 <acquire>

  p->state = RUNNABLE;
80103bb5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103bbc:	c7 04 24 e0 3f 11 80 	movl   $0x80113fe0,(%esp)
80103bc3:	e8 08 0f 00 00       	call   80104ad0 <release>
}
80103bc8:	83 c4 10             	add    $0x10,%esp
80103bcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bce:	c9                   	leave  
80103bcf:	c3                   	ret    

  p = allocproc();

  initproc = p;
  if ((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103bd0:	83 ec 0c             	sub    $0xc,%esp
80103bd3:	68 0c 7c 10 80       	push   $0x80107c0c
80103bd8:	e8 93 c7 ff ff       	call   80100370 <panic>
80103bdd:	8d 76 00             	lea    0x0(%esi),%esi

80103be0 <growproc>:
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int growproc(int n)
{
80103be0:	55                   	push   %ebp
80103be1:	89 e5                	mov    %esp,%ebp
80103be3:	56                   	push   %esi
80103be4:	53                   	push   %ebx
80103be5:	8b 75 08             	mov    0x8(%ebp),%esi
struct proc *
myproc(void)
{
  struct cpu *c;
  struct proc *p;
  pushcli();
80103be8:	e8 53 0d 00 00       	call   80104940 <pushcli>
  c = mycpu();
80103bed:	e8 2e fe ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80103bf2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103bf8:	e8 83 0d 00 00       	call   80104980 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if (n > 0)
80103bfd:	83 fe 00             	cmp    $0x0,%esi
int growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103c00:	8b 03                	mov    (%ebx),%eax
  if (n > 0)
80103c02:	7e 34                	jle    80103c38 <growproc+0x58>
  {
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c04:	83 ec 04             	sub    $0x4,%esp
80103c07:	01 c6                	add    %eax,%esi
80103c09:	56                   	push   %esi
80103c0a:	50                   	push   %eax
80103c0b:	ff 73 04             	pushl  0x4(%ebx)
80103c0e:	e8 1d 36 00 00       	call   80107230 <allocuvm>
80103c13:	83 c4 10             	add    $0x10,%esp
80103c16:	85 c0                	test   %eax,%eax
80103c18:	74 36                	je     80103c50 <growproc+0x70>
  {
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
80103c1a:	83 ec 0c             	sub    $0xc,%esp
  else if (n < 0)
  {
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103c1d:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103c1f:	53                   	push   %ebx
80103c20:	e8 bb 33 00 00       	call   80106fe0 <switchuvm>
  return 0;
80103c25:	83 c4 10             	add    $0x10,%esp
80103c28:	31 c0                	xor    %eax,%eax
}
80103c2a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c2d:	5b                   	pop    %ebx
80103c2e:	5e                   	pop    %esi
80103c2f:	5d                   	pop    %ebp
80103c30:	c3                   	ret    
80103c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if (n > 0)
  {
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  else if (n < 0)
80103c38:	74 e0                	je     80103c1a <growproc+0x3a>
  {
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c3a:	83 ec 04             	sub    $0x4,%esp
80103c3d:	01 c6                	add    %eax,%esi
80103c3f:	56                   	push   %esi
80103c40:	50                   	push   %eax
80103c41:	ff 73 04             	pushl  0x4(%ebx)
80103c44:	e8 e7 36 00 00       	call   80107330 <deallocuvm>
80103c49:	83 c4 10             	add    $0x10,%esp
80103c4c:	85 c0                	test   %eax,%eax
80103c4e:	75 ca                	jne    80103c1a <growproc+0x3a>

  sz = curproc->sz;
  if (n > 0)
  {
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103c50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c55:	eb d3                	jmp    80103c2a <growproc+0x4a>
80103c57:	89 f6                	mov    %esi,%esi
80103c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c60 <fork>:

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int fork(void)
{
80103c60:	55                   	push   %ebp
80103c61:	89 e5                	mov    %esp,%ebp
80103c63:	57                   	push   %edi
80103c64:	56                   	push   %esi
80103c65:	53                   	push   %ebx
80103c66:	83 ec 1c             	sub    $0x1c,%esp
struct proc *
myproc(void)
{
  struct cpu *c;
  struct proc *p;
  pushcli();
80103c69:	e8 d2 0c 00 00       	call   80104940 <pushcli>
  c = mycpu();
80103c6e:	e8 ad fd ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80103c73:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c79:	e8 02 0d 00 00       	call   80104980 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if ((np = allocproc()) == 0)
80103c7e:	e8 5d fc ff ff       	call   801038e0 <allocproc>
80103c83:	85 c0                	test   %eax,%eax
80103c85:	89 c7                	mov    %eax,%edi
80103c87:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c8a:	0f 84 b5 00 00 00    	je     80103d45 <fork+0xe5>
  {
    return -1;
  }

  // Copy process state from proc.
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
80103c90:	83 ec 08             	sub    $0x8,%esp
80103c93:	ff 33                	pushl  (%ebx)
80103c95:	ff 73 04             	pushl  0x4(%ebx)
80103c98:	e8 13 38 00 00       	call   801074b0 <copyuvm>
80103c9d:	83 c4 10             	add    $0x10,%esp
80103ca0:	85 c0                	test   %eax,%eax
80103ca2:	89 47 04             	mov    %eax,0x4(%edi)
80103ca5:	0f 84 a1 00 00 00    	je     80103d4c <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103cab:	8b 03                	mov    (%ebx),%eax
80103cad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103cb0:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103cb2:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103cb5:	89 c8                	mov    %ecx,%eax
80103cb7:	8b 79 18             	mov    0x18(%ecx),%edi
80103cba:	8b 73 18             	mov    0x18(%ebx),%esi
80103cbd:	b9 13 00 00 00       	mov    $0x13,%ecx
80103cc2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for (i = 0; i < NOFILE; i++)
80103cc4:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103cc6:	8b 40 18             	mov    0x18(%eax),%eax
80103cc9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for (i = 0; i < NOFILE; i++)
    if (curproc->ofile[i])
80103cd0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103cd4:	85 c0                	test   %eax,%eax
80103cd6:	74 13                	je     80103ceb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103cd8:	83 ec 0c             	sub    $0xc,%esp
80103cdb:	50                   	push   %eax
80103cdc:	e8 2f d4 ff ff       	call   80101110 <filedup>
80103ce1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ce4:	83 c4 10             	add    $0x10,%esp
80103ce7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for (i = 0; i < NOFILE; i++)
80103ceb:	83 c6 01             	add    $0x1,%esi
80103cee:	83 fe 10             	cmp    $0x10,%esi
80103cf1:	75 dd                	jne    80103cd0 <fork+0x70>
    if (curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103cf3:	83 ec 0c             	sub    $0xc,%esp
80103cf6:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103cf9:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for (i = 0; i < NOFILE; i++)
    if (curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103cfc:	e8 6f dc ff ff       	call   80101970 <idup>
80103d01:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d04:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for (i = 0; i < NOFILE; i++)
    if (curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103d07:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d0a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103d0d:	6a 10                	push   $0x10
80103d0f:	53                   	push   %ebx
80103d10:	50                   	push   %eax
80103d11:	e8 0a 10 00 00       	call   80104d20 <safestrcpy>

  pid = np->pid;
80103d16:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103d19:	c7 04 24 e0 3f 11 80 	movl   $0x80113fe0,(%esp)
80103d20:	e8 fb 0c 00 00       	call   80104a20 <acquire>

  np->state = RUNNABLE;
80103d25:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103d2c:	c7 04 24 e0 3f 11 80 	movl   $0x80113fe0,(%esp)
80103d33:	e8 98 0d 00 00       	call   80104ad0 <release>

  return pid;
80103d38:	83 c4 10             	add    $0x10,%esp
80103d3b:	89 d8                	mov    %ebx,%eax
}
80103d3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d40:	5b                   	pop    %ebx
80103d41:	5e                   	pop    %esi
80103d42:	5f                   	pop    %edi
80103d43:	5d                   	pop    %ebp
80103d44:	c3                   	ret    
  struct proc *curproc = myproc();

  // Allocate process.
  if ((np = allocproc()) == 0)
  {
    return -1;
80103d45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d4a:	eb f1                	jmp    80103d3d <fork+0xdd>
  }

  // Copy process state from proc.
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
  {
    kfree(np->kstack);
80103d4c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103d4f:	83 ec 0c             	sub    $0xc,%esp
80103d52:	ff 77 08             	pushl  0x8(%edi)
80103d55:	e8 b6 e8 ff ff       	call   80102610 <kfree>
    np->kstack = 0;
80103d5a:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103d61:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103d68:	83 c4 10             	add    $0x10,%esp
80103d6b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d70:	eb cb                	jmp    80103d3d <fork+0xdd>
80103d72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d80 <scheduler>:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void scheduler(void)
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	57                   	push   %edi
80103d84:	56                   	push   %esi
80103d85:	53                   	push   %ebx
80103d86:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103d89:	e8 92 fc ff ff       	call   80103a20 <mycpu>
80103d8e:	8d 78 04             	lea    0x4(%eax),%edi
80103d91:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103d93:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103d9a:	00 00 00 
80103d9d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103da0:	fb                   	sti    
  {
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103da1:	83 ec 0c             	sub    $0xc,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103da4:	bb 14 40 11 80       	mov    $0x80114014,%ebx
  {
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103da9:	68 e0 3f 11 80       	push   $0x80113fe0
80103dae:	e8 6d 0c 00 00       	call   80104a20 <acquire>
80103db3:	83 c4 10             	add    $0x10,%esp
80103db6:	eb 16                	jmp    80103dce <scheduler+0x4e>
80103db8:	90                   	nop
80103db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dc0:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103dc6:	81 fb 14 61 11 80    	cmp    $0x80116114,%ebx
80103dcc:	74 4a                	je     80103e18 <scheduler+0x98>
    {
      if (p->state != RUNNABLE)
80103dce:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103dd2:	75 ec                	jne    80103dc0 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103dd4:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103dd7:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103ddd:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dde:	81 c3 84 00 00 00    	add    $0x84,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103de4:	e8 f7 31 00 00       	call   80106fe0 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103de9:	58                   	pop    %eax
80103dea:	5a                   	pop    %edx
80103deb:	ff 73 98             	pushl  -0x68(%ebx)
80103dee:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103def:	c7 43 88 04 00 00 00 	movl   $0x4,-0x78(%ebx)

      swtch(&(c->scheduler), p->context);
80103df6:	e8 80 0f 00 00       	call   80104d7b <swtch>
      switchkvm();
80103dfb:	e8 c0 31 00 00       	call   80106fc0 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103e00:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e03:	81 fb 14 61 11 80    	cmp    $0x80116114,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103e09:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103e10:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e13:	75 b9                	jne    80103dce <scheduler+0x4e>
80103e15:	8d 76 00             	lea    0x0(%esi),%esi

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103e18:	83 ec 0c             	sub    $0xc,%esp
80103e1b:	68 e0 3f 11 80       	push   $0x80113fe0
80103e20:	e8 ab 0c 00 00       	call   80104ad0 <release>
  }
80103e25:	83 c4 10             	add    $0x10,%esp
80103e28:	e9 73 ff ff ff       	jmp    80103da0 <scheduler+0x20>
80103e2d:	8d 76 00             	lea    0x0(%esi),%esi

80103e30 <sched>:
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void sched(void)
{
80103e30:	55                   	push   %ebp
80103e31:	89 e5                	mov    %esp,%ebp
80103e33:	56                   	push   %esi
80103e34:	53                   	push   %ebx
struct proc *
myproc(void)
{
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e35:	e8 06 0b 00 00       	call   80104940 <pushcli>
  c = mycpu();
80103e3a:	e8 e1 fb ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80103e3f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e45:	e8 36 0b 00 00       	call   80104980 <popcli>
void sched(void)
{
  int intena;
  struct proc *p = myproc();

  if (!holding(&ptable.lock))
80103e4a:	83 ec 0c             	sub    $0xc,%esp
80103e4d:	68 e0 3f 11 80       	push   $0x80113fe0
80103e52:	e8 99 0b 00 00       	call   801049f0 <holding>
80103e57:	83 c4 10             	add    $0x10,%esp
80103e5a:	85 c0                	test   %eax,%eax
80103e5c:	74 4f                	je     80103ead <sched+0x7d>
    panic("sched ptable.lock");
  if (mycpu()->ncli != 1)
80103e5e:	e8 bd fb ff ff       	call   80103a20 <mycpu>
80103e63:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103e6a:	75 68                	jne    80103ed4 <sched+0xa4>
    panic("sched locks");
  if (p->state == RUNNING)
80103e6c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103e70:	74 55                	je     80103ec7 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e72:	9c                   	pushf  
80103e73:	58                   	pop    %eax
    panic("sched running");
  if (readeflags() & FL_IF)
80103e74:	f6 c4 02             	test   $0x2,%ah
80103e77:	75 41                	jne    80103eba <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103e79:	e8 a2 fb ff ff       	call   80103a20 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103e7e:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if (p->state == RUNNING)
    panic("sched running");
  if (readeflags() & FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103e81:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103e87:	e8 94 fb ff ff       	call   80103a20 <mycpu>
80103e8c:	83 ec 08             	sub    $0x8,%esp
80103e8f:	ff 70 04             	pushl  0x4(%eax)
80103e92:	53                   	push   %ebx
80103e93:	e8 e3 0e 00 00       	call   80104d7b <swtch>
  mycpu()->intena = intena;
80103e98:	e8 83 fb ff ff       	call   80103a20 <mycpu>
}
80103e9d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if (readeflags() & FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103ea0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103ea6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ea9:	5b                   	pop    %ebx
80103eaa:	5e                   	pop    %esi
80103eab:	5d                   	pop    %ebp
80103eac:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if (!holding(&ptable.lock))
    panic("sched ptable.lock");
80103ead:	83 ec 0c             	sub    $0xc,%esp
80103eb0:	68 30 7c 10 80       	push   $0x80107c30
80103eb5:	e8 b6 c4 ff ff       	call   80100370 <panic>
  if (mycpu()->ncli != 1)
    panic("sched locks");
  if (p->state == RUNNING)
    panic("sched running");
  if (readeflags() & FL_IF)
    panic("sched interruptible");
80103eba:	83 ec 0c             	sub    $0xc,%esp
80103ebd:	68 5c 7c 10 80       	push   $0x80107c5c
80103ec2:	e8 a9 c4 ff ff       	call   80100370 <panic>
  if (!holding(&ptable.lock))
    panic("sched ptable.lock");
  if (mycpu()->ncli != 1)
    panic("sched locks");
  if (p->state == RUNNING)
    panic("sched running");
80103ec7:	83 ec 0c             	sub    $0xc,%esp
80103eca:	68 4e 7c 10 80       	push   $0x80107c4e
80103ecf:	e8 9c c4 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if (!holding(&ptable.lock))
    panic("sched ptable.lock");
  if (mycpu()->ncli != 1)
    panic("sched locks");
80103ed4:	83 ec 0c             	sub    $0xc,%esp
80103ed7:	68 42 7c 10 80       	push   $0x80107c42
80103edc:	e8 8f c4 ff ff       	call   80100370 <panic>
80103ee1:	eb 0d                	jmp    80103ef0 <exit>
80103ee3:	90                   	nop
80103ee4:	90                   	nop
80103ee5:	90                   	nop
80103ee6:	90                   	nop
80103ee7:	90                   	nop
80103ee8:	90                   	nop
80103ee9:	90                   	nop
80103eea:	90                   	nop
80103eeb:	90                   	nop
80103eec:	90                   	nop
80103eed:	90                   	nop
80103eee:	90                   	nop
80103eef:	90                   	nop

80103ef0 <exit>:

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void exit(void)
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	57                   	push   %edi
80103ef4:	56                   	push   %esi
80103ef5:	53                   	push   %ebx
80103ef6:	83 ec 0c             	sub    $0xc,%esp
struct proc *
myproc(void)
{
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ef9:	e8 42 0a 00 00       	call   80104940 <pushcli>
  c = mycpu();
80103efe:	e8 1d fb ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80103f03:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f09:	e8 72 0a 00 00       	call   80104980 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if (curproc == initproc)
80103f0e:	39 35 f8 b5 10 80    	cmp    %esi,0x8010b5f8
80103f14:	8d 5e 28             	lea    0x28(%esi),%ebx
80103f17:	8d 7e 68             	lea    0x68(%esi),%edi
80103f1a:	0f 84 f1 00 00 00    	je     80104011 <exit+0x121>
    panic("init exiting");

  // Close all open files.
  for (fd = 0; fd < NOFILE; fd++)
  {
    if (curproc->ofile[fd])
80103f20:	8b 03                	mov    (%ebx),%eax
80103f22:	85 c0                	test   %eax,%eax
80103f24:	74 12                	je     80103f38 <exit+0x48>
    {
      fileclose(curproc->ofile[fd]);
80103f26:	83 ec 0c             	sub    $0xc,%esp
80103f29:	50                   	push   %eax
80103f2a:	e8 31 d2 ff ff       	call   80101160 <fileclose>
      curproc->ofile[fd] = 0;
80103f2f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103f35:	83 c4 10             	add    $0x10,%esp
80103f38:	83 c3 04             	add    $0x4,%ebx

  if (curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for (fd = 0; fd < NOFILE; fd++)
80103f3b:	39 df                	cmp    %ebx,%edi
80103f3d:	75 e1                	jne    80103f20 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103f3f:	e8 3c ef ff ff       	call   80102e80 <begin_op>
  iput(curproc->cwd);
80103f44:	83 ec 0c             	sub    $0xc,%esp
80103f47:	ff 76 68             	pushl  0x68(%esi)
80103f4a:	e8 81 db ff ff       	call   80101ad0 <iput>
  end_op();
80103f4f:	e8 9c ef ff ff       	call   80102ef0 <end_op>
  curproc->cwd = 0;
80103f54:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103f5b:	c7 04 24 e0 3f 11 80 	movl   $0x80113fe0,(%esp)
80103f62:	e8 b9 0a 00 00       	call   80104a20 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103f67:	8b 56 14             	mov    0x14(%esi),%edx
80103f6a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f6d:	b8 14 40 11 80       	mov    $0x80114014,%eax
80103f72:	eb 10                	jmp    80103f84 <exit+0x94>
80103f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f78:	05 84 00 00 00       	add    $0x84,%eax
80103f7d:	3d 14 61 11 80       	cmp    $0x80116114,%eax
80103f82:	74 1e                	je     80103fa2 <exit+0xb2>
    if (p->state == SLEEPING && p->chan == chan)
80103f84:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f88:	75 ee                	jne    80103f78 <exit+0x88>
80103f8a:	3b 50 20             	cmp    0x20(%eax),%edx
80103f8d:	75 e9                	jne    80103f78 <exit+0x88>
      p->state = RUNNABLE;
80103f8f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f96:	05 84 00 00 00       	add    $0x84,%eax
80103f9b:	3d 14 61 11 80       	cmp    $0x80116114,%eax
80103fa0:	75 e2                	jne    80103f84 <exit+0x94>
  // Pass abandoned children to init.
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->parent == curproc)
    {
      p->parent = initproc;
80103fa2:	8b 0d f8 b5 10 80    	mov    0x8010b5f8,%ecx
80103fa8:	ba 14 40 11 80       	mov    $0x80114014,%edx
80103fad:	eb 0f                	jmp    80103fbe <exit+0xce>
80103faf:	90                   	nop

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fb0:	81 c2 84 00 00 00    	add    $0x84,%edx
80103fb6:	81 fa 14 61 11 80    	cmp    $0x80116114,%edx
80103fbc:	74 3a                	je     80103ff8 <exit+0x108>
  {
    if (p->parent == curproc)
80103fbe:	39 72 14             	cmp    %esi,0x14(%edx)
80103fc1:	75 ed                	jne    80103fb0 <exit+0xc0>
    {
      p->parent = initproc;
      if (p->state == ZOMBIE)
80103fc3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  // Pass abandoned children to init.
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->parent == curproc)
    {
      p->parent = initproc;
80103fc7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if (p->state == ZOMBIE)
80103fca:	75 e4                	jne    80103fb0 <exit+0xc0>
80103fcc:	b8 14 40 11 80       	mov    $0x80114014,%eax
80103fd1:	eb 11                	jmp    80103fe4 <exit+0xf4>
80103fd3:	90                   	nop
80103fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fd8:	05 84 00 00 00       	add    $0x84,%eax
80103fdd:	3d 14 61 11 80       	cmp    $0x80116114,%eax
80103fe2:	74 cc                	je     80103fb0 <exit+0xc0>
    if (p->state == SLEEPING && p->chan == chan)
80103fe4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103fe8:	75 ee                	jne    80103fd8 <exit+0xe8>
80103fea:	3b 48 20             	cmp    0x20(%eax),%ecx
80103fed:	75 e9                	jne    80103fd8 <exit+0xe8>
      p->state = RUNNABLE;
80103fef:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103ff6:	eb e0                	jmp    80103fd8 <exit+0xe8>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103ff8:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103fff:	e8 2c fe ff ff       	call   80103e30 <sched>
  panic("zombie exit");
80104004:	83 ec 0c             	sub    $0xc,%esp
80104007:	68 7d 7c 10 80       	push   $0x80107c7d
8010400c:	e8 5f c3 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if (curproc == initproc)
    panic("init exiting");
80104011:	83 ec 0c             	sub    $0xc,%esp
80104014:	68 70 7c 10 80       	push   $0x80107c70
80104019:	e8 52 c3 ff ff       	call   80100370 <panic>
8010401e:	66 90                	xchg   %ax,%ax

80104020 <yield>:
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void yield(void)
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	53                   	push   %ebx
80104024:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock); //DOC: yieldlock
80104027:	68 e0 3f 11 80       	push   $0x80113fe0
8010402c:	e8 ef 09 00 00       	call   80104a20 <acquire>
struct proc *
myproc(void)
{
  struct cpu *c;
  struct proc *p;
  pushcli();
80104031:	e8 0a 09 00 00       	call   80104940 <pushcli>
  c = mycpu();
80104036:	e8 e5 f9 ff ff       	call   80103a20 <mycpu>
  p = c->proc;
8010403b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104041:	e8 3a 09 00 00       	call   80104980 <popcli>

// Give up the CPU for one scheduling round.
void yield(void)
{
  acquire(&ptable.lock); //DOC: yieldlock
  myproc()->state = RUNNABLE;
80104046:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010404d:	e8 de fd ff ff       	call   80103e30 <sched>
  release(&ptable.lock);
80104052:	c7 04 24 e0 3f 11 80 	movl   $0x80113fe0,(%esp)
80104059:	e8 72 0a 00 00       	call   80104ad0 <release>
}
8010405e:	83 c4 10             	add    $0x10,%esp
80104061:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104064:	c9                   	leave  
80104065:	c3                   	ret    
80104066:	8d 76 00             	lea    0x0(%esi),%esi
80104069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104070 <sleep>:
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk)
{
80104070:	55                   	push   %ebp
80104071:	89 e5                	mov    %esp,%ebp
80104073:	57                   	push   %edi
80104074:	56                   	push   %esi
80104075:	53                   	push   %ebx
80104076:	83 ec 0c             	sub    $0xc,%esp
80104079:	8b 7d 08             	mov    0x8(%ebp),%edi
8010407c:	8b 75 0c             	mov    0xc(%ebp),%esi
struct proc *
myproc(void)
{
  struct cpu *c;
  struct proc *p;
  pushcli();
8010407f:	e8 bc 08 00 00       	call   80104940 <pushcli>
  c = mycpu();
80104084:	e8 97 f9 ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80104089:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010408f:	e8 ec 08 00 00       	call   80104980 <popcli>
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();

  if (p == 0)
80104094:	85 db                	test   %ebx,%ebx
80104096:	0f 84 87 00 00 00    	je     80104123 <sleep+0xb3>
    panic("sleep");

  if (lk == 0)
8010409c:	85 f6                	test   %esi,%esi
8010409e:	74 76                	je     80104116 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if (lk != &ptable.lock)
801040a0:	81 fe e0 3f 11 80    	cmp    $0x80113fe0,%esi
801040a6:	74 50                	je     801040f8 <sleep+0x88>
  {                        //DOC: sleeplock0
    acquire(&ptable.lock); //DOC: sleeplock1
801040a8:	83 ec 0c             	sub    $0xc,%esp
801040ab:	68 e0 3f 11 80       	push   $0x80113fe0
801040b0:	e8 6b 09 00 00       	call   80104a20 <acquire>
    release(lk);
801040b5:	89 34 24             	mov    %esi,(%esp)
801040b8:	e8 13 0a 00 00       	call   80104ad0 <release>
  }
  // Go to sleep.
  p->chan = chan;
801040bd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801040c0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
801040c7:	e8 64 fd ff ff       	call   80103e30 <sched>

  // Tidy up.
  p->chan = 0;
801040cc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if (lk != &ptable.lock)
  { //DOC: sleeplock2
    release(&ptable.lock);
801040d3:	c7 04 24 e0 3f 11 80 	movl   $0x80113fe0,(%esp)
801040da:	e8 f1 09 00 00       	call   80104ad0 <release>
    acquire(lk);
801040df:	89 75 08             	mov    %esi,0x8(%ebp)
801040e2:	83 c4 10             	add    $0x10,%esp
  }
}
801040e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040e8:	5b                   	pop    %ebx
801040e9:	5e                   	pop    %esi
801040ea:	5f                   	pop    %edi
801040eb:	5d                   	pop    %ebp

  // Reacquire original lock.
  if (lk != &ptable.lock)
  { //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
801040ec:	e9 2f 09 00 00       	jmp    80104a20 <acquire>
801040f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  {                        //DOC: sleeplock0
    acquire(&ptable.lock); //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
801040f8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801040fb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104102:	e8 29 fd ff ff       	call   80103e30 <sched>

  // Tidy up.
  p->chan = 0;
80104107:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  if (lk != &ptable.lock)
  { //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
8010410e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104111:	5b                   	pop    %ebx
80104112:	5e                   	pop    %esi
80104113:	5f                   	pop    %edi
80104114:	5d                   	pop    %ebp
80104115:	c3                   	ret    

  if (p == 0)
    panic("sleep");

  if (lk == 0)
    panic("sleep without lk");
80104116:	83 ec 0c             	sub    $0xc,%esp
80104119:	68 8f 7c 10 80       	push   $0x80107c8f
8010411e:	e8 4d c2 ff ff       	call   80100370 <panic>
void sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();

  if (p == 0)
    panic("sleep");
80104123:	83 ec 0c             	sub    $0xc,%esp
80104126:	68 89 7c 10 80       	push   $0x80107c89
8010412b:	e8 40 c2 ff ff       	call   80100370 <panic>

80104130 <wait>:
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int wait(void)
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	56                   	push   %esi
80104134:	53                   	push   %ebx
struct proc *
myproc(void)
{
  struct cpu *c;
  struct proc *p;
  pushcli();
80104135:	e8 06 08 00 00       	call   80104940 <pushcli>
  c = mycpu();
8010413a:	e8 e1 f8 ff ff       	call   80103a20 <mycpu>
  p = c->proc;
8010413f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104145:	e8 36 08 00 00       	call   80104980 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
8010414a:	83 ec 0c             	sub    $0xc,%esp
8010414d:	68 e0 3f 11 80       	push   $0x80113fe0
80104152:	e8 c9 08 00 00       	call   80104a20 <acquire>
80104157:	83 c4 10             	add    $0x10,%esp
  for (;;)
  {
    // Scan through table looking for exited children.
    havekids = 0;
8010415a:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010415c:	bb 14 40 11 80       	mov    $0x80114014,%ebx
80104161:	eb 13                	jmp    80104176 <wait+0x46>
80104163:	90                   	nop
80104164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104168:	81 c3 84 00 00 00    	add    $0x84,%ebx
8010416e:	81 fb 14 61 11 80    	cmp    $0x80116114,%ebx
80104174:	74 22                	je     80104198 <wait+0x68>
    {
      if (p->parent != curproc)
80104176:	39 73 14             	cmp    %esi,0x14(%ebx)
80104179:	75 ed                	jne    80104168 <wait+0x38>
        continue;
      havekids = 1;
      if (p->state == ZOMBIE)
8010417b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010417f:	74 35                	je     801041b6 <wait+0x86>
  acquire(&ptable.lock);
  for (;;)
  {
    // Scan through table looking for exited children.
    havekids = 0;
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104181:	81 c3 84 00 00 00    	add    $0x84,%ebx
    {
      if (p->parent != curproc)
        continue;
      havekids = 1;
80104187:	b8 01 00 00 00       	mov    $0x1,%eax
  acquire(&ptable.lock);
  for (;;)
  {
    // Scan through table looking for exited children.
    havekids = 0;
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010418c:	81 fb 14 61 11 80    	cmp    $0x80116114,%ebx
80104192:	75 e2                	jne    80104176 <wait+0x46>
80104194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if (!havekids || curproc->killed)
80104198:	85 c0                	test   %eax,%eax
8010419a:	74 70                	je     8010420c <wait+0xdc>
8010419c:	8b 46 24             	mov    0x24(%esi),%eax
8010419f:	85 c0                	test   %eax,%eax
801041a1:	75 69                	jne    8010420c <wait+0xdc>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock); //DOC: wait-sleep
801041a3:	83 ec 08             	sub    $0x8,%esp
801041a6:	68 e0 3f 11 80       	push   $0x80113fe0
801041ab:	56                   	push   %esi
801041ac:	e8 bf fe ff ff       	call   80104070 <sleep>
  }
801041b1:	83 c4 10             	add    $0x10,%esp
801041b4:	eb a4                	jmp    8010415a <wait+0x2a>
      havekids = 1;
      if (p->state == ZOMBIE)
      {
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
801041b6:	83 ec 0c             	sub    $0xc,%esp
801041b9:	ff 73 08             	pushl  0x8(%ebx)
        continue;
      havekids = 1;
      if (p->state == ZOMBIE)
      {
        // Found one.
        pid = p->pid;
801041bc:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801041bf:	e8 4c e4 ff ff       	call   80102610 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
801041c4:	5a                   	pop    %edx
801041c5:	ff 73 04             	pushl  0x4(%ebx)
      if (p->state == ZOMBIE)
      {
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
801041c8:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801041cf:	e8 8c 31 00 00       	call   80107360 <freevm>
        p->pid = 0;
801041d4:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801041db:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801041e2:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801041e6:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801041ed:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801041f4:	c7 04 24 e0 3f 11 80 	movl   $0x80113fe0,(%esp)
801041fb:	e8 d0 08 00 00       	call   80104ad0 <release>
        return pid;
80104200:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock); //DOC: wait-sleep
  }
}
80104203:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80104206:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock); //DOC: wait-sleep
  }
}
80104208:	5b                   	pop    %ebx
80104209:	5e                   	pop    %esi
8010420a:	5d                   	pop    %ebp
8010420b:	c3                   	ret    
    }

    // No point waiting if we don't have any children.
    if (!havekids || curproc->killed)
    {
      release(&ptable.lock);
8010420c:	83 ec 0c             	sub    $0xc,%esp
8010420f:	68 e0 3f 11 80       	push   $0x80113fe0
80104214:	e8 b7 08 00 00       	call   80104ad0 <release>
      return -1;
80104219:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock); //DOC: wait-sleep
  }
}
8010421c:	8d 65 f8             	lea    -0x8(%ebp),%esp

    // No point waiting if we don't have any children.
    if (!havekids || curproc->killed)
    {
      release(&ptable.lock);
      return -1;
8010421f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock); //DOC: wait-sleep
  }
}
80104224:	5b                   	pop    %ebx
80104225:	5e                   	pop    %esi
80104226:	5d                   	pop    %ebp
80104227:	c3                   	ret    
80104228:	90                   	nop
80104229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104230 <wakeup>:
      p->state = RUNNABLE;
}

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
80104230:	55                   	push   %ebp
80104231:	89 e5                	mov    %esp,%ebp
80104233:	53                   	push   %ebx
80104234:	83 ec 10             	sub    $0x10,%esp
80104237:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010423a:	68 e0 3f 11 80       	push   $0x80113fe0
8010423f:	e8 dc 07 00 00       	call   80104a20 <acquire>
80104244:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104247:	b8 14 40 11 80       	mov    $0x80114014,%eax
8010424c:	eb 0e                	jmp    8010425c <wakeup+0x2c>
8010424e:	66 90                	xchg   %ax,%ax
80104250:	05 84 00 00 00       	add    $0x84,%eax
80104255:	3d 14 61 11 80       	cmp    $0x80116114,%eax
8010425a:	74 1e                	je     8010427a <wakeup+0x4a>
    if (p->state == SLEEPING && p->chan == chan)
8010425c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104260:	75 ee                	jne    80104250 <wakeup+0x20>
80104262:	3b 58 20             	cmp    0x20(%eax),%ebx
80104265:	75 e9                	jne    80104250 <wakeup+0x20>
      p->state = RUNNABLE;
80104267:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010426e:	05 84 00 00 00       	add    $0x84,%eax
80104273:	3d 14 61 11 80       	cmp    $0x80116114,%eax
80104278:	75 e2                	jne    8010425c <wakeup+0x2c>
// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
8010427a:	c7 45 08 e0 3f 11 80 	movl   $0x80113fe0,0x8(%ebp)
}
80104281:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104284:	c9                   	leave  
// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104285:	e9 46 08 00 00       	jmp    80104ad0 <release>
8010428a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104290 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	53                   	push   %ebx
80104294:	83 ec 10             	sub    $0x10,%esp
80104297:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010429a:	68 e0 3f 11 80       	push   $0x80113fe0
8010429f:	e8 7c 07 00 00       	call   80104a20 <acquire>
801042a4:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042a7:	b8 14 40 11 80       	mov    $0x80114014,%eax
801042ac:	eb 0e                	jmp    801042bc <kill+0x2c>
801042ae:	66 90                	xchg   %ax,%ax
801042b0:	05 84 00 00 00       	add    $0x84,%eax
801042b5:	3d 14 61 11 80       	cmp    $0x80116114,%eax
801042ba:	74 3c                	je     801042f8 <kill+0x68>
  {
    if (p->pid == pid)
801042bc:	39 58 10             	cmp    %ebx,0x10(%eax)
801042bf:	75 ef                	jne    801042b0 <kill+0x20>
    {
      p->killed = 1;
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
801042c1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  acquire(&ptable.lock);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->pid == pid)
    {
      p->killed = 1;
801042c5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
801042cc:	74 1a                	je     801042e8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
801042ce:	83 ec 0c             	sub    $0xc,%esp
801042d1:	68 e0 3f 11 80       	push   $0x80113fe0
801042d6:	e8 f5 07 00 00       	call   80104ad0 <release>
      return 0;
801042db:	83 c4 10             	add    $0x10,%esp
801042de:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801042e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042e3:	c9                   	leave  
801042e4:	c3                   	ret    
801042e5:	8d 76 00             	lea    0x0(%esi),%esi
    if (p->pid == pid)
    {
      p->killed = 1;
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
        p->state = RUNNABLE;
801042e8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801042ef:	eb dd                	jmp    801042ce <kill+0x3e>
801042f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801042f8:	83 ec 0c             	sub    $0xc,%esp
801042fb:	68 e0 3f 11 80       	push   $0x80113fe0
80104300:	e8 cb 07 00 00       	call   80104ad0 <release>
  return -1;
80104305:	83 c4 10             	add    $0x10,%esp
80104308:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010430d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104310:	c9                   	leave  
80104311:	c3                   	ret    
80104312:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104320 <procdump>:
//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void procdump(void)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	57                   	push   %edi
80104324:	56                   	push   %esi
80104325:	53                   	push   %ebx
80104326:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104329:	bb 80 40 11 80       	mov    $0x80114080,%ebx
8010432e:	83 ec 3c             	sub    $0x3c,%esp
80104331:	eb 27                	jmp    8010435a <procdump+0x3a>
80104333:	90                   	nop
80104334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
      for (i = 0; i < 10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	68 53 81 10 80       	push   $0x80108153
80104340:	e8 1b c3 ff ff       	call   80100660 <cprintf>
80104345:	83 c4 10             	add    $0x10,%esp
80104348:	81 c3 84 00 00 00    	add    $0x84,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010434e:	81 fb 80 61 11 80    	cmp    $0x80116180,%ebx
80104354:	0f 84 7e 00 00 00    	je     801043d8 <procdump+0xb8>
  {
    if (p->state == UNUSED)
8010435a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010435d:	85 c0                	test   %eax,%eax
8010435f:	74 e7                	je     80104348 <procdump+0x28>
      continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104361:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104364:	ba a0 7c 10 80       	mov    $0x80107ca0,%edx

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->state == UNUSED)
      continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104369:	77 11                	ja     8010437c <procdump+0x5c>
8010436b:	8b 14 85 24 7e 10 80 	mov    -0x7fef81dc(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
80104372:	b8 a0 7c 10 80       	mov    $0x80107ca0,%eax
80104377:	85 d2                	test   %edx,%edx
80104379:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010437c:	53                   	push   %ebx
8010437d:	52                   	push   %edx
8010437e:	ff 73 a4             	pushl  -0x5c(%ebx)
80104381:	68 a4 7c 10 80       	push   $0x80107ca4
80104386:	e8 d5 c2 ff ff       	call   80100660 <cprintf>
    if (p->state == SLEEPING)
8010438b:	83 c4 10             	add    $0x10,%esp
8010438e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104392:	75 a4                	jne    80104338 <procdump+0x18>
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
80104394:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104397:	83 ec 08             	sub    $0x8,%esp
8010439a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010439d:	50                   	push   %eax
8010439e:	8b 43 b0             	mov    -0x50(%ebx),%eax
801043a1:	8b 40 0c             	mov    0xc(%eax),%eax
801043a4:	83 c0 08             	add    $0x8,%eax
801043a7:	50                   	push   %eax
801043a8:	e8 33 05 00 00       	call   801048e0 <getcallerpcs>
801043ad:	83 c4 10             	add    $0x10,%esp
      for (i = 0; i < 10 && pc[i] != 0; i++)
801043b0:	8b 17                	mov    (%edi),%edx
801043b2:	85 d2                	test   %edx,%edx
801043b4:	74 82                	je     80104338 <procdump+0x18>
        cprintf(" %p", pc[i]);
801043b6:	83 ec 08             	sub    $0x8,%esp
801043b9:	83 c7 04             	add    $0x4,%edi
801043bc:	52                   	push   %edx
801043bd:	68 e1 76 10 80       	push   $0x801076e1
801043c2:	e8 99 c2 ff ff       	call   80100660 <cprintf>
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if (p->state == SLEEPING)
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
      for (i = 0; i < 10 && pc[i] != 0; i++)
801043c7:	83 c4 10             	add    $0x10,%esp
801043ca:	39 f7                	cmp    %esi,%edi
801043cc:	75 e2                	jne    801043b0 <procdump+0x90>
801043ce:	e9 65 ff ff ff       	jmp    80104338 <procdump+0x18>
801043d3:	90                   	nop
801043d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801043d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043db:	5b                   	pop    %ebx
801043dc:	5e                   	pop    %esi
801043dd:	5f                   	pop    %edi
801043de:	5d                   	pop    %ebp
801043df:	c3                   	ret    

801043e0 <printProcess>:

void printProcess(struct proc *p)
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	53                   	push   %ebx
801043e4:	83 ec 0c             	sub    $0xc,%esp
801043e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  cprintf("name : %s\n", p->name);
801043ea:	8d 43 6c             	lea    0x6c(%ebx),%eax
801043ed:	50                   	push   %eax
801043ee:	68 ad 7c 10 80       	push   $0x80107cad
801043f3:	e8 68 c2 ff ff       	call   80100660 <cprintf>
  cprintf("PID : %d\n", p->pid);
801043f8:	58                   	pop    %eax
801043f9:	5a                   	pop    %edx
801043fa:	ff 73 10             	pushl  0x10(%ebx)
801043fd:	68 b9 7c 10 80       	push   $0x80107cb9
80104402:	e8 59 c2 ff ff       	call   80100660 <cprintf>
  cprintf("PPID : %d\n", p->parent->pid);
80104407:	59                   	pop    %ecx
80104408:	58                   	pop    %eax
80104409:	8b 43 14             	mov    0x14(%ebx),%eax
8010440c:	ff 70 10             	pushl  0x10(%eax)
8010440f:	68 b8 7c 10 80       	push   $0x80107cb8
80104414:	e8 47 c2 ff ff       	call   80100660 <cprintf>
  switch (p->state)
80104419:	83 c4 10             	add    $0x10,%esp
8010441c:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104420:	77 6e                	ja     80104490 <printProcess+0xb0>
80104422:	8b 43 0c             	mov    0xc(%ebx),%eax
80104425:	ff 24 85 0c 7e 10 80 	jmp    *-0x7fef81f4(,%eax,4)
8010442c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    break;
  case 3:
    cprintf("state : RUNNABLE\n");
    break;
  case 4:
    cprintf("state : RUNNING\n");
80104430:	c7 45 08 07 7d 10 80 	movl   $0x80107d07,0x8(%ebp)
    break;
  case 5:
    cprintf("state : ZOMBIE\n");
    break;
  }
}
80104437:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010443a:	c9                   	leave  
    break;
  case 3:
    cprintf("state : RUNNABLE\n");
    break;
  case 4:
    cprintf("state : RUNNING\n");
8010443b:	e9 20 c2 ff ff       	jmp    80100660 <cprintf>
    break;
  case 5:
    cprintf("state : ZOMBIE\n");
80104440:	c7 45 08 18 7d 10 80 	movl   $0x80107d18,0x8(%ebp)
    break;
  }
}
80104447:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010444a:	c9                   	leave  
    break;
  case 4:
    cprintf("state : RUNNING\n");
    break;
  case 5:
    cprintf("state : ZOMBIE\n");
8010444b:	e9 10 c2 ff ff       	jmp    80100660 <cprintf>
  cprintf("PID : %d\n", p->pid);
  cprintf("PPID : %d\n", p->parent->pid);
  switch (p->state)
  {
  case 0:
    cprintf("state : UNUSED\n");
80104450:	c7 45 08 c3 7c 10 80 	movl   $0x80107cc3,0x8(%ebp)
    break;
  case 5:
    cprintf("state : ZOMBIE\n");
    break;
  }
}
80104457:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010445a:	c9                   	leave  
  cprintf("PID : %d\n", p->pid);
  cprintf("PPID : %d\n", p->parent->pid);
  switch (p->state)
  {
  case 0:
    cprintf("state : UNUSED\n");
8010445b:	e9 00 c2 ff ff       	jmp    80100660 <cprintf>
    break;
  case 1:
    cprintf("state : EMBRYO\n");
80104460:	c7 45 08 d3 7c 10 80 	movl   $0x80107cd3,0x8(%ebp)
    break;
  case 5:
    cprintf("state : ZOMBIE\n");
    break;
  }
}
80104467:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010446a:	c9                   	leave  
  {
  case 0:
    cprintf("state : UNUSED\n");
    break;
  case 1:
    cprintf("state : EMBRYO\n");
8010446b:	e9 f0 c1 ff ff       	jmp    80100660 <cprintf>
    break;
  case 2:
    cprintf("state : SLEEPING\n");
80104470:	c7 45 08 e3 7c 10 80 	movl   $0x80107ce3,0x8(%ebp)
    break;
  case 5:
    cprintf("state : ZOMBIE\n");
    break;
  }
}
80104477:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010447a:	c9                   	leave  
    break;
  case 1:
    cprintf("state : EMBRYO\n");
    break;
  case 2:
    cprintf("state : SLEEPING\n");
8010447b:	e9 e0 c1 ff ff       	jmp    80100660 <cprintf>
    break;
  case 3:
    cprintf("state : RUNNABLE\n");
80104480:	c7 45 08 f5 7c 10 80 	movl   $0x80107cf5,0x8(%ebp)
    break;
  case 5:
    cprintf("state : ZOMBIE\n");
    break;
  }
}
80104487:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010448a:	c9                   	leave  
    break;
  case 2:
    cprintf("state : SLEEPING\n");
    break;
  case 3:
    cprintf("state : RUNNABLE\n");
8010448b:	e9 d0 c1 ff ff       	jmp    80100660 <cprintf>
    break;
  case 5:
    cprintf("state : ZOMBIE\n");
    break;
  }
}
80104490:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104493:	c9                   	leave  
80104494:	c3                   	ret    
80104495:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044a0 <getprocs>:

int getprocs(void)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	53                   	push   %ebx
  struct proc *p;
  cprintf("\n-----------------------------\n");
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044a4:	bb 14 40 11 80       	mov    $0x80114014,%ebx
    break;
  }
}

int getprocs(void)
{
801044a9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  cprintf("\n-----------------------------\n");
801044ac:	68 ec 7d 10 80       	push   $0x80107dec
801044b1:	e8 aa c1 ff ff       	call   80100660 <cprintf>
801044b6:	83 c4 10             	add    $0x10,%esp
801044b9:	eb 13                	jmp    801044ce <getprocs+0x2e>
801044bb:	90                   	nop
801044bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044c0:	81 c3 84 00 00 00    	add    $0x84,%ebx
801044c6:	81 fb 14 61 11 80    	cmp    $0x80116114,%ebx
801044cc:	74 2d                	je     801044fb <getprocs+0x5b>
  {
    if (p->pid == 0)
801044ce:	8b 43 10             	mov    0x10(%ebx),%eax
801044d1:	85 c0                	test   %eax,%eax
801044d3:	74 eb                	je     801044c0 <getprocs+0x20>
      continue;
    printProcess(p);
801044d5:	83 ec 0c             	sub    $0xc,%esp
801044d8:	53                   	push   %ebx

int getprocs(void)
{
  struct proc *p;
  cprintf("\n-----------------------------\n");
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044d9:	81 c3 84 00 00 00    	add    $0x84,%ebx
  {
    if (p->pid == 0)
      continue;
    printProcess(p);
801044df:	e8 fc fe ff ff       	call   801043e0 <printProcess>
    cprintf("\n-----------------------------\n");
801044e4:	c7 04 24 ec 7d 10 80 	movl   $0x80107dec,(%esp)
801044eb:	e8 70 c1 ff ff       	call   80100660 <cprintf>
801044f0:	83 c4 10             	add    $0x10,%esp

int getprocs(void)
{
  struct proc *p;
  cprintf("\n-----------------------------\n");
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044f3:	81 fb 14 61 11 80    	cmp    $0x80116114,%ebx
801044f9:	75 d3                	jne    801044ce <getprocs+0x2e>
      continue;
    printProcess(p);
    cprintf("\n-----------------------------\n");
  }
  return 23;
}
801044fb:	b8 17 00 00 00       	mov    $0x17,%eax
80104500:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104503:	c9                   	leave  
80104504:	c3                   	ret    
80104505:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104510 <printstack>:

int printstack(void)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	53                   	push   %ebx
80104514:	83 ec 04             	sub    $0x4,%esp
struct proc *
myproc(void)
{
  struct cpu *c;
  struct proc *p;
  pushcli();
80104517:	e8 24 04 00 00       	call   80104940 <pushcli>
  c = mycpu();
8010451c:	e8 ff f4 ff ff       	call   80103a20 <mycpu>
  p = c->proc;
80104521:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104527:	e8 54 04 00 00       	call   80104980 <popcli>
}

int printstack(void)
{
  struct proc *process = myproc();
  cprintf("eax:%x\n", &(process->tf->eax));
8010452c:	83 ec 08             	sub    $0x8,%esp
8010452f:	8b 43 18             	mov    0x18(%ebx),%eax
80104532:	83 c0 1c             	add    $0x1c,%eax
80104535:	50                   	push   %eax
80104536:	68 28 7d 10 80       	push   $0x80107d28
8010453b:	e8 20 c1 ff ff       	call   80100660 <cprintf>
  cprintf("ebx:%x\n", &(process->tf->ebx));
80104540:	58                   	pop    %eax
80104541:	8b 43 18             	mov    0x18(%ebx),%eax
80104544:	5a                   	pop    %edx
80104545:	83 c0 10             	add    $0x10,%eax
80104548:	50                   	push   %eax
80104549:	68 30 7d 10 80       	push   $0x80107d30
8010454e:	e8 0d c1 ff ff       	call   80100660 <cprintf>
  cprintf("ecx:%x\n", &(process->tf->ecx));
80104553:	59                   	pop    %ecx
80104554:	58                   	pop    %eax
80104555:	8b 43 18             	mov    0x18(%ebx),%eax
80104558:	83 c0 18             	add    $0x18,%eax
8010455b:	50                   	push   %eax
8010455c:	68 38 7d 10 80       	push   $0x80107d38
80104561:	e8 fa c0 ff ff       	call   80100660 <cprintf>
  cprintf("edx:%x\n", &(process->tf->edx));
80104566:	58                   	pop    %eax
80104567:	8b 43 18             	mov    0x18(%ebx),%eax
8010456a:	5a                   	pop    %edx
8010456b:	83 c0 14             	add    $0x14,%eax
8010456e:	50                   	push   %eax
8010456f:	68 40 7d 10 80       	push   $0x80107d40
80104574:	e8 e7 c0 ff ff       	call   80100660 <cprintf>
  cprintf("esi:%x\n", &(process->tf->esi));
80104579:	59                   	pop    %ecx
8010457a:	58                   	pop    %eax
8010457b:	8b 43 18             	mov    0x18(%ebx),%eax
8010457e:	83 c0 04             	add    $0x4,%eax
80104581:	50                   	push   %eax
80104582:	68 48 7d 10 80       	push   $0x80107d48
80104587:	e8 d4 c0 ff ff       	call   80100660 <cprintf>
  cprintf("edi:%x\n", &(process->tf->edi));
8010458c:	58                   	pop    %eax
8010458d:	5a                   	pop    %edx
8010458e:	ff 73 18             	pushl  0x18(%ebx)
80104591:	68 50 7d 10 80       	push   $0x80107d50
80104596:	e8 c5 c0 ff ff       	call   80100660 <cprintf>
  cprintf("ebp:%x\n", &(process->tf->ebp));
8010459b:	59                   	pop    %ecx
8010459c:	58                   	pop    %eax
8010459d:	8b 43 18             	mov    0x18(%ebx),%eax
801045a0:	83 c0 08             	add    $0x8,%eax
801045a3:	50                   	push   %eax
801045a4:	68 58 7d 10 80       	push   $0x80107d58
801045a9:	e8 b2 c0 ff ff       	call   80100660 <cprintf>
  cprintf("err:%x\n", &(process->tf->err));
801045ae:	58                   	pop    %eax
801045af:	8b 43 18             	mov    0x18(%ebx),%eax
801045b2:	5a                   	pop    %edx
801045b3:	83 c0 34             	add    $0x34,%eax
801045b6:	50                   	push   %eax
801045b7:	68 60 7d 10 80       	push   $0x80107d60
801045bc:	e8 9f c0 ff ff       	call   80100660 <cprintf>
  cprintf("eip:%x\n", &(process->tf->eip));
801045c1:	59                   	pop    %ecx
801045c2:	58                   	pop    %eax
801045c3:	8b 43 18             	mov    0x18(%ebx),%eax
801045c6:	83 c0 38             	add    $0x38,%eax
801045c9:	50                   	push   %eax
801045ca:	68 68 7d 10 80       	push   $0x80107d68
801045cf:	e8 8c c0 ff ff       	call   80100660 <cprintf>
  cprintf("esp:%x\n", &(process->tf->esp));
801045d4:	58                   	pop    %eax
801045d5:	8b 43 18             	mov    0x18(%ebx),%eax
801045d8:	5a                   	pop    %edx
801045d9:	83 c0 44             	add    $0x44,%eax
801045dc:	50                   	push   %eax
801045dd:	68 70 7d 10 80       	push   $0x80107d70
801045e2:	e8 79 c0 ff ff       	call   80100660 <cprintf>
  cprintf("eflags:%x\n", &(process->tf->eflags));
801045e7:	59                   	pop    %ecx
801045e8:	58                   	pop    %eax
801045e9:	8b 43 18             	mov    0x18(%ebx),%eax
801045ec:	83 c0 40             	add    $0x40,%eax
801045ef:	50                   	push   %eax
801045f0:	68 78 7d 10 80       	push   $0x80107d78
801045f5:	e8 66 c0 ff ff       	call   80100660 <cprintf>
  return 24;
}
801045fa:	b8 18 00 00 00       	mov    $0x18,%eax
801045ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104602:	c9                   	leave  
80104603:	c3                   	ret    
80104604:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010460a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104610 <clone>:

// Create a new thread
int clone(void (*fcn)(void *), void *arg, void *stack)
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	57                   	push   %edi
80104614:	56                   	push   %esi
80104615:	53                   	push   %ebx
80104616:	83 ec 1c             	sub    $0x1c,%esp
80104619:	8b 55 10             	mov    0x10(%ebp),%edx
  if ((uint)stack % PGSIZE != 0 || (uint)stack + PGSIZE > (proc->sz))
8010461c:	f7 c2 ff 0f 00 00    	test   $0xfff,%edx
80104622:	0f 85 09 01 00 00    	jne    80104731 <clone+0x121>
80104628:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010462e:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80104634:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104637:	3b 08                	cmp    (%eax),%ecx
80104639:	0f 87 f2 00 00 00    	ja     80104731 <clone+0x121>

  int i, pid;
  struct proc *np;

  // Allocate process.
  if ((np = allocproc()) == 0)
8010463f:	e8 9c f2 ff ff       	call   801038e0 <allocproc>
80104644:	85 c0                	test   %eax,%eax
80104646:	89 c3                	mov    %eax,%ebx
80104648:	0f 84 e3 00 00 00    	je     80104731 <clone+0x121>
    return -1;

  // Copy process state from p.
  np->pgdir = proc->pgdir;
8010464e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;
80104654:	8b 7b 18             	mov    0x18(%ebx),%edi

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  np->ustack = stack;
80104657:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  // Allocate process.
  if ((np = allocproc()) == 0)
    return -1;

  // Copy process state from p.
  np->pgdir = proc->pgdir;
8010465a:	8b 48 04             	mov    0x4(%eax),%ecx
8010465d:	89 4b 04             	mov    %ecx,0x4(%ebx)
  np->sz = proc->sz;
80104660:	8b 00                	mov    (%eax),%eax
  np->parent = proc;
  *np->tf = *proc->tf;
80104662:	b9 13 00 00 00       	mov    $0x13,%ecx
  if ((np = allocproc()) == 0)
    return -1;

  // Copy process state from p.
  np->pgdir = proc->pgdir;
  np->sz = proc->sz;
80104667:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80104669:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010466f:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80104672:	8b 70 18             	mov    0x18(%eax),%esi
80104675:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  *((uint *)(stack + PGSIZE - sizeof(uint))) = (uint)arg;
  *((uint *)(stack + PGSIZE - 2 * sizeof(uint))) = 0xffffffff;
  np->tf->esp = (uint)stack + PGSIZE - 2 * sizeof(uint);
  np->tf->eip = (uint)fcn;

  for (i = 0; i < NOFILE; i++)
80104677:	31 f6                	xor    %esi,%esi
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104679:	8b 43 18             	mov    0x18(%ebx),%eax
8010467c:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  np->ustack = stack;
  *((uint *)(stack + PGSIZE - sizeof(uint))) = (uint)arg;
80104683:	8b 45 0c             	mov    0xc(%ebp),%eax
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  np->ustack = stack;
80104686:	89 53 7c             	mov    %edx,0x7c(%ebx)
  *((uint *)(stack + PGSIZE - sizeof(uint))) = (uint)arg;
  *((uint *)(stack + PGSIZE - 2 * sizeof(uint))) = 0xffffffff;
80104689:	c7 82 f8 0f 00 00 ff 	movl   $0xffffffff,0xff8(%edx)
80104690:	ff ff ff 
  np->tf->esp = (uint)stack + PGSIZE - 2 * sizeof(uint);
80104693:	81 c2 f8 0f 00 00    	add    $0xff8,%edx

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  np->ustack = stack;
  *((uint *)(stack + PGSIZE - sizeof(uint))) = (uint)arg;
80104699:	89 42 04             	mov    %eax,0x4(%edx)
  *((uint *)(stack + PGSIZE - 2 * sizeof(uint))) = 0xffffffff;
  np->tf->esp = (uint)stack + PGSIZE - 2 * sizeof(uint);
8010469c:	8b 43 18             	mov    0x18(%ebx),%eax
8010469f:	89 50 44             	mov    %edx,0x44(%eax)
  np->tf->eip = (uint)fcn;
801046a2:	8b 55 08             	mov    0x8(%ebp),%edx
801046a5:	8b 43 18             	mov    0x18(%ebx),%eax
801046a8:	89 50 38             	mov    %edx,0x38(%eax)
801046ab:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801046b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for (i = 0; i < NOFILE; i++)
    if (proc->ofile[i])
801046b8:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
801046bc:	85 c0                	test   %eax,%eax
801046be:	74 17                	je     801046d7 <clone+0xc7>
      np->ofile[i] = filedup(proc->ofile[i]);
801046c0:	83 ec 0c             	sub    $0xc,%esp
801046c3:	50                   	push   %eax
801046c4:	e8 47 ca ff ff       	call   80101110 <filedup>
801046c9:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
801046cd:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801046d4:	83 c4 10             	add    $0x10,%esp
  *((uint *)(stack + PGSIZE - sizeof(uint))) = (uint)arg;
  *((uint *)(stack + PGSIZE - 2 * sizeof(uint))) = 0xffffffff;
  np->tf->esp = (uint)stack + PGSIZE - 2 * sizeof(uint);
  np->tf->eip = (uint)fcn;

  for (i = 0; i < NOFILE; i++)
801046d7:	83 c6 01             	add    $0x1,%esi
801046da:	83 fe 10             	cmp    $0x10,%esi
801046dd:	75 d9                	jne    801046b8 <clone+0xa8>
    if (proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
801046df:	83 ec 0c             	sub    $0xc,%esp
801046e2:	ff 72 68             	pushl  0x68(%edx)
801046e5:	e8 86 d2 ff ff       	call   80101970 <idup>
801046ea:	89 43 68             	mov    %eax,0x68(%ebx)

  pid = np->pid;
  np->state = RUNNABLE;
  safestrcpy(np->name, proc->name, sizeof(proc->name));
801046ed:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046f3:	83 c4 0c             	add    $0xc,%esp
  for (i = 0; i < NOFILE; i++)
    if (proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);

  pid = np->pid;
801046f6:	8b 73 10             	mov    0x10(%ebx),%esi
  np->state = RUNNABLE;
801046f9:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104700:	6a 10                	push   $0x10
80104702:	83 c0 6c             	add    $0x6c,%eax
80104705:	50                   	push   %eax
80104706:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104709:	50                   	push   %eax
8010470a:	e8 11 06 00 00       	call   80104d20 <safestrcpy>

  np->reference_count = proc->reference_count;
8010470f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  *(np->reference_count) = *(np->reference_count) + 1;
  return pid;
80104715:	83 c4 10             	add    $0x10,%esp

  pid = np->pid;
  np->state = RUNNABLE;
  safestrcpy(np->name, proc->name, sizeof(proc->name));

  np->reference_count = proc->reference_count;
80104718:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
8010471e:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  *(np->reference_count) = *(np->reference_count) + 1;
80104724:	83 00 01             	addl   $0x1,(%eax)
  return pid;
}
80104727:	8d 65 f4             	lea    -0xc(%ebp),%esp
  np->state = RUNNABLE;
  safestrcpy(np->name, proc->name, sizeof(proc->name));

  np->reference_count = proc->reference_count;
  *(np->reference_count) = *(np->reference_count) + 1;
  return pid;
8010472a:	89 f0                	mov    %esi,%eax
}
8010472c:	5b                   	pop    %ebx
8010472d:	5e                   	pop    %esi
8010472e:	5f                   	pop    %edi
8010472f:	5d                   	pop    %ebp
80104730:	c3                   	ret    
80104731:	8d 65 f4             	lea    -0xc(%ebp),%esp
// Create a new thread
int clone(void (*fcn)(void *), void *arg, void *stack)
{
  if ((uint)stack % PGSIZE != 0 || (uint)stack + PGSIZE > (proc->sz))
  {
    return -1;
80104734:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  safestrcpy(np->name, proc->name, sizeof(proc->name));

  np->reference_count = proc->reference_count;
  *(np->reference_count) = *(np->reference_count) + 1;
  return pid;
}
80104739:	5b                   	pop    %ebx
8010473a:	5e                   	pop    %esi
8010473b:	5f                   	pop    %edi
8010473c:	5d                   	pop    %ebp
8010473d:	c3                   	ret    
8010473e:	66 90                	xchg   %ax,%ax

80104740 <thread_create>:

int thread_create(void (*start_routine)(void *), void *arg)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	83 ec 08             	sub    $0x8,%esp
  void *stack = kalloc();
80104746:	e8 75 e0 ff ff       	call   801027c0 <kalloc>
  if (!stack)
8010474b:	85 c0                	test   %eax,%eax
8010474d:	74 22                	je     80104771 <thread_create+0x31>
  {
    cprintf("Error: malloc failed\n");
    exit();
  }

  if ((uint)stack % PGSIZE)
8010474f:	89 c2                	mov    %eax,%edx
80104751:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
80104757:	74 07                	je     80104760 <thread_create+0x20>
  {
    stack = stack + (4096 - (uint)stack % PGSIZE);
80104759:	29 d0                	sub    %edx,%eax
8010475b:	05 00 10 00 00       	add    $0x1000,%eax
  }

  return clone(start_routine, arg, stack);
80104760:	83 ec 04             	sub    $0x4,%esp
80104763:	50                   	push   %eax
80104764:	ff 75 0c             	pushl  0xc(%ebp)
80104767:	ff 75 08             	pushl  0x8(%ebp)
8010476a:	e8 a1 fe ff ff       	call   80104610 <clone>
}
8010476f:	c9                   	leave  
80104770:	c3                   	ret    
int thread_create(void (*start_routine)(void *), void *arg)
{
  void *stack = kalloc();
  if (!stack)
  {
    cprintf("Error: malloc failed\n");
80104771:	83 ec 0c             	sub    $0xc,%esp
80104774:	68 83 7d 10 80       	push   $0x80107d83
80104779:	e8 e2 be ff ff       	call   80100660 <cprintf>
    exit();
8010477e:	e8 6d f7 ff ff       	call   80103ef0 <exit>
80104783:	66 90                	xchg   %ax,%ax
80104785:	66 90                	xchg   %ax,%ax
80104787:	66 90                	xchg   %ax,%ax
80104789:	66 90                	xchg   %ax,%ax
8010478b:	66 90                	xchg   %ax,%ax
8010478d:	66 90                	xchg   %ax,%ax
8010478f:	90                   	nop

80104790 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	53                   	push   %ebx
80104794:	83 ec 0c             	sub    $0xc,%esp
80104797:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010479a:	68 3c 7e 10 80       	push   $0x80107e3c
8010479f:	8d 43 04             	lea    0x4(%ebx),%eax
801047a2:	50                   	push   %eax
801047a3:	e8 18 01 00 00       	call   801048c0 <initlock>
  lk->name = name;
801047a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801047ab:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801047b1:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
801047b4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801047bb:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801047be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047c1:	c9                   	leave  
801047c2:	c3                   	ret    
801047c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047d0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	56                   	push   %esi
801047d4:	53                   	push   %ebx
801047d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801047d8:	83 ec 0c             	sub    $0xc,%esp
801047db:	8d 73 04             	lea    0x4(%ebx),%esi
801047de:	56                   	push   %esi
801047df:	e8 3c 02 00 00       	call   80104a20 <acquire>
  while (lk->locked) {
801047e4:	8b 13                	mov    (%ebx),%edx
801047e6:	83 c4 10             	add    $0x10,%esp
801047e9:	85 d2                	test   %edx,%edx
801047eb:	74 16                	je     80104803 <acquiresleep+0x33>
801047ed:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801047f0:	83 ec 08             	sub    $0x8,%esp
801047f3:	56                   	push   %esi
801047f4:	53                   	push   %ebx
801047f5:	e8 76 f8 ff ff       	call   80104070 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
801047fa:	8b 03                	mov    (%ebx),%eax
801047fc:	83 c4 10             	add    $0x10,%esp
801047ff:	85 c0                	test   %eax,%eax
80104801:	75 ed                	jne    801047f0 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104803:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104809:	e8 b2 f2 ff ff       	call   80103ac0 <myproc>
8010480e:	8b 40 10             	mov    0x10(%eax),%eax
80104811:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104814:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104817:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010481a:	5b                   	pop    %ebx
8010481b:	5e                   	pop    %esi
8010481c:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010481d:	e9 ae 02 00 00       	jmp    80104ad0 <release>
80104822:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104830 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	56                   	push   %esi
80104834:	53                   	push   %ebx
80104835:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104838:	83 ec 0c             	sub    $0xc,%esp
8010483b:	8d 73 04             	lea    0x4(%ebx),%esi
8010483e:	56                   	push   %esi
8010483f:	e8 dc 01 00 00       	call   80104a20 <acquire>
  lk->locked = 0;
80104844:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010484a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104851:	89 1c 24             	mov    %ebx,(%esp)
80104854:	e8 d7 f9 ff ff       	call   80104230 <wakeup>
  release(&lk->lk);
80104859:	89 75 08             	mov    %esi,0x8(%ebp)
8010485c:	83 c4 10             	add    $0x10,%esp
}
8010485f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104862:	5b                   	pop    %ebx
80104863:	5e                   	pop    %esi
80104864:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104865:	e9 66 02 00 00       	jmp    80104ad0 <release>
8010486a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104870 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	57                   	push   %edi
80104874:	56                   	push   %esi
80104875:	53                   	push   %ebx
80104876:	31 ff                	xor    %edi,%edi
80104878:	83 ec 18             	sub    $0x18,%esp
8010487b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010487e:	8d 73 04             	lea    0x4(%ebx),%esi
80104881:	56                   	push   %esi
80104882:	e8 99 01 00 00       	call   80104a20 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104887:	8b 03                	mov    (%ebx),%eax
80104889:	83 c4 10             	add    $0x10,%esp
8010488c:	85 c0                	test   %eax,%eax
8010488e:	74 13                	je     801048a3 <holdingsleep+0x33>
80104890:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104893:	e8 28 f2 ff ff       	call   80103ac0 <myproc>
80104898:	39 58 10             	cmp    %ebx,0x10(%eax)
8010489b:	0f 94 c0             	sete   %al
8010489e:	0f b6 c0             	movzbl %al,%eax
801048a1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801048a3:	83 ec 0c             	sub    $0xc,%esp
801048a6:	56                   	push   %esi
801048a7:	e8 24 02 00 00       	call   80104ad0 <release>
  return r;
}
801048ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048af:	89 f8                	mov    %edi,%eax
801048b1:	5b                   	pop    %ebx
801048b2:	5e                   	pop    %esi
801048b3:	5f                   	pop    %edi
801048b4:	5d                   	pop    %ebp
801048b5:	c3                   	ret    
801048b6:	66 90                	xchg   %ax,%ax
801048b8:	66 90                	xchg   %ax,%ax
801048ba:	66 90                	xchg   %ax,%ax
801048bc:	66 90                	xchg   %ax,%ax
801048be:	66 90                	xchg   %ax,%ax

801048c0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801048c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801048c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801048cf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801048d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801048d9:	5d                   	pop    %ebp
801048da:	c3                   	ret    
801048db:	90                   	nop
801048dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048e0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801048e4:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801048e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801048ea:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801048ed:	31 c0                	xor    %eax,%eax
801048ef:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801048f0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801048f6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801048fc:	77 1a                	ja     80104918 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801048fe:	8b 5a 04             	mov    0x4(%edx),%ebx
80104901:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104904:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104907:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104909:	83 f8 0a             	cmp    $0xa,%eax
8010490c:	75 e2                	jne    801048f0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010490e:	5b                   	pop    %ebx
8010490f:	5d                   	pop    %ebp
80104910:	c3                   	ret    
80104911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104918:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010491f:	83 c0 01             	add    $0x1,%eax
80104922:	83 f8 0a             	cmp    $0xa,%eax
80104925:	74 e7                	je     8010490e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104927:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010492e:	83 c0 01             	add    $0x1,%eax
80104931:	83 f8 0a             	cmp    $0xa,%eax
80104934:	75 e2                	jne    80104918 <getcallerpcs+0x38>
80104936:	eb d6                	jmp    8010490e <getcallerpcs+0x2e>
80104938:	90                   	nop
80104939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104940 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104940:	55                   	push   %ebp
80104941:	89 e5                	mov    %esp,%ebp
80104943:	53                   	push   %ebx
80104944:	83 ec 04             	sub    $0x4,%esp
80104947:	9c                   	pushf  
80104948:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104949:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010494a:	e8 d1 f0 ff ff       	call   80103a20 <mycpu>
8010494f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104955:	85 c0                	test   %eax,%eax
80104957:	75 11                	jne    8010496a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104959:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010495f:	e8 bc f0 ff ff       	call   80103a20 <mycpu>
80104964:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010496a:	e8 b1 f0 ff ff       	call   80103a20 <mycpu>
8010496f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104976:	83 c4 04             	add    $0x4,%esp
80104979:	5b                   	pop    %ebx
8010497a:	5d                   	pop    %ebp
8010497b:	c3                   	ret    
8010497c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104980 <popcli>:

void
popcli(void)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104986:	9c                   	pushf  
80104987:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104988:	f6 c4 02             	test   $0x2,%ah
8010498b:	75 52                	jne    801049df <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010498d:	e8 8e f0 ff ff       	call   80103a20 <mycpu>
80104992:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104998:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010499b:	85 d2                	test   %edx,%edx
8010499d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801049a3:	78 2d                	js     801049d2 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801049a5:	e8 76 f0 ff ff       	call   80103a20 <mycpu>
801049aa:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801049b0:	85 d2                	test   %edx,%edx
801049b2:	74 0c                	je     801049c0 <popcli+0x40>
    sti();
}
801049b4:	c9                   	leave  
801049b5:	c3                   	ret    
801049b6:	8d 76 00             	lea    0x0(%esi),%esi
801049b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801049c0:	e8 5b f0 ff ff       	call   80103a20 <mycpu>
801049c5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801049cb:	85 c0                	test   %eax,%eax
801049cd:	74 e5                	je     801049b4 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
801049cf:	fb                   	sti    
    sti();
}
801049d0:	c9                   	leave  
801049d1:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
801049d2:	83 ec 0c             	sub    $0xc,%esp
801049d5:	68 5e 7e 10 80       	push   $0x80107e5e
801049da:	e8 91 b9 ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
801049df:	83 ec 0c             	sub    $0xc,%esp
801049e2:	68 47 7e 10 80       	push   $0x80107e47
801049e7:	e8 84 b9 ff ff       	call   80100370 <panic>
801049ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049f0 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	56                   	push   %esi
801049f4:	53                   	push   %ebx
801049f5:	8b 75 08             	mov    0x8(%ebp),%esi
801049f8:	31 db                	xor    %ebx,%ebx
  int r;
  pushcli();
801049fa:	e8 41 ff ff ff       	call   80104940 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801049ff:	8b 06                	mov    (%esi),%eax
80104a01:	85 c0                	test   %eax,%eax
80104a03:	74 10                	je     80104a15 <holding+0x25>
80104a05:	8b 5e 08             	mov    0x8(%esi),%ebx
80104a08:	e8 13 f0 ff ff       	call   80103a20 <mycpu>
80104a0d:	39 c3                	cmp    %eax,%ebx
80104a0f:	0f 94 c3             	sete   %bl
80104a12:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104a15:	e8 66 ff ff ff       	call   80104980 <popcli>
  return r;
}
80104a1a:	89 d8                	mov    %ebx,%eax
80104a1c:	5b                   	pop    %ebx
80104a1d:	5e                   	pop    %esi
80104a1e:	5d                   	pop    %ebp
80104a1f:	c3                   	ret    

80104a20 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	53                   	push   %ebx
80104a24:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104a27:	e8 14 ff ff ff       	call   80104940 <pushcli>
  if(holding(lk))
80104a2c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a2f:	83 ec 0c             	sub    $0xc,%esp
80104a32:	53                   	push   %ebx
80104a33:	e8 b8 ff ff ff       	call   801049f0 <holding>
80104a38:	83 c4 10             	add    $0x10,%esp
80104a3b:	85 c0                	test   %eax,%eax
80104a3d:	0f 85 7d 00 00 00    	jne    80104ac0 <acquire+0xa0>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104a43:	ba 01 00 00 00       	mov    $0x1,%edx
80104a48:	eb 09                	jmp    80104a53 <acquire+0x33>
80104a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a50:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a53:	89 d0                	mov    %edx,%eax
80104a55:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104a58:	85 c0                	test   %eax,%eax
80104a5a:	75 f4                	jne    80104a50 <acquire+0x30>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80104a5c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104a61:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a64:	e8 b7 ef ff ff       	call   80103a20 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104a69:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
80104a6b:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104a6e:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104a71:	31 c0                	xor    %eax,%eax
80104a73:	90                   	nop
80104a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104a78:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104a7e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104a84:	77 1a                	ja     80104aa0 <acquire+0x80>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104a86:	8b 5a 04             	mov    0x4(%edx),%ebx
80104a89:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104a8c:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104a8f:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104a91:	83 f8 0a             	cmp    $0xa,%eax
80104a94:	75 e2                	jne    80104a78 <acquire+0x58>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80104a96:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a99:	c9                   	leave  
80104a9a:	c3                   	ret    
80104a9b:	90                   	nop
80104a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104aa0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104aa7:	83 c0 01             	add    $0x1,%eax
80104aaa:	83 f8 0a             	cmp    $0xa,%eax
80104aad:	74 e7                	je     80104a96 <acquire+0x76>
    pcs[i] = 0;
80104aaf:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104ab6:	83 c0 01             	add    $0x1,%eax
80104ab9:	83 f8 0a             	cmp    $0xa,%eax
80104abc:	75 e2                	jne    80104aa0 <acquire+0x80>
80104abe:	eb d6                	jmp    80104a96 <acquire+0x76>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104ac0:	83 ec 0c             	sub    $0xc,%esp
80104ac3:	68 65 7e 10 80       	push   $0x80107e65
80104ac8:	e8 a3 b8 ff ff       	call   80100370 <panic>
80104acd:	8d 76 00             	lea    0x0(%esi),%esi

80104ad0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	53                   	push   %ebx
80104ad4:	83 ec 10             	sub    $0x10,%esp
80104ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104ada:	53                   	push   %ebx
80104adb:	e8 10 ff ff ff       	call   801049f0 <holding>
80104ae0:	83 c4 10             	add    $0x10,%esp
80104ae3:	85 c0                	test   %eax,%eax
80104ae5:	74 22                	je     80104b09 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
80104ae7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104aee:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80104af5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104afa:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80104b00:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b03:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80104b04:	e9 77 fe ff ff       	jmp    80104980 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80104b09:	83 ec 0c             	sub    $0xc,%esp
80104b0c:	68 6d 7e 10 80       	push   $0x80107e6d
80104b11:	e8 5a b8 ff ff       	call   80100370 <panic>
80104b16:	66 90                	xchg   %ax,%ax
80104b18:	66 90                	xchg   %ax,%ax
80104b1a:	66 90                	xchg   %ax,%ax
80104b1c:	66 90                	xchg   %ax,%ax
80104b1e:	66 90                	xchg   %ax,%ax

80104b20 <memset>:
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	57                   	push   %edi
80104b24:	53                   	push   %ebx
80104b25:	8b 55 08             	mov    0x8(%ebp),%edx
80104b28:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104b2b:	f6 c2 03             	test   $0x3,%dl
80104b2e:	75 05                	jne    80104b35 <memset+0x15>
80104b30:	f6 c1 03             	test   $0x3,%cl
80104b33:	74 13                	je     80104b48 <memset+0x28>
80104b35:	89 d7                	mov    %edx,%edi
80104b37:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b3a:	fc                   	cld    
80104b3b:	f3 aa                	rep stos %al,%es:(%edi)
80104b3d:	5b                   	pop    %ebx
80104b3e:	89 d0                	mov    %edx,%eax
80104b40:	5f                   	pop    %edi
80104b41:	5d                   	pop    %ebp
80104b42:	c3                   	ret    
80104b43:	90                   	nop
80104b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b48:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
80104b4c:	c1 e9 02             	shr    $0x2,%ecx
80104b4f:	89 fb                	mov    %edi,%ebx
80104b51:	89 f8                	mov    %edi,%eax
80104b53:	c1 e3 18             	shl    $0x18,%ebx
80104b56:	c1 e0 10             	shl    $0x10,%eax
80104b59:	09 d8                	or     %ebx,%eax
80104b5b:	09 f8                	or     %edi,%eax
80104b5d:	c1 e7 08             	shl    $0x8,%edi
80104b60:	09 f8                	or     %edi,%eax
80104b62:	89 d7                	mov    %edx,%edi
80104b64:	fc                   	cld    
80104b65:	f3 ab                	rep stos %eax,%es:(%edi)
80104b67:	5b                   	pop    %ebx
80104b68:	89 d0                	mov    %edx,%eax
80104b6a:	5f                   	pop    %edi
80104b6b:	5d                   	pop    %ebp
80104b6c:	c3                   	ret    
80104b6d:	8d 76 00             	lea    0x0(%esi),%esi

80104b70 <memcmp>:
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	57                   	push   %edi
80104b74:	56                   	push   %esi
80104b75:	8b 45 10             	mov    0x10(%ebp),%eax
80104b78:	53                   	push   %ebx
80104b79:	8b 75 0c             	mov    0xc(%ebp),%esi
80104b7c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104b7f:	85 c0                	test   %eax,%eax
80104b81:	74 29                	je     80104bac <memcmp+0x3c>
80104b83:	0f b6 13             	movzbl (%ebx),%edx
80104b86:	0f b6 0e             	movzbl (%esi),%ecx
80104b89:	38 d1                	cmp    %dl,%cl
80104b8b:	75 2b                	jne    80104bb8 <memcmp+0x48>
80104b8d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104b90:	31 c0                	xor    %eax,%eax
80104b92:	eb 14                	jmp    80104ba8 <memcmp+0x38>
80104b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b98:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
80104b9d:	83 c0 01             	add    $0x1,%eax
80104ba0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104ba4:	38 ca                	cmp    %cl,%dl
80104ba6:	75 10                	jne    80104bb8 <memcmp+0x48>
80104ba8:	39 f8                	cmp    %edi,%eax
80104baa:	75 ec                	jne    80104b98 <memcmp+0x28>
80104bac:	5b                   	pop    %ebx
80104bad:	31 c0                	xor    %eax,%eax
80104baf:	5e                   	pop    %esi
80104bb0:	5f                   	pop    %edi
80104bb1:	5d                   	pop    %ebp
80104bb2:	c3                   	ret    
80104bb3:	90                   	nop
80104bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bb8:	0f b6 c2             	movzbl %dl,%eax
80104bbb:	5b                   	pop    %ebx
80104bbc:	29 c8                	sub    %ecx,%eax
80104bbe:	5e                   	pop    %esi
80104bbf:	5f                   	pop    %edi
80104bc0:	5d                   	pop    %ebp
80104bc1:	c3                   	ret    
80104bc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bd0 <memmove>:
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	56                   	push   %esi
80104bd4:	53                   	push   %ebx
80104bd5:	8b 45 08             	mov    0x8(%ebp),%eax
80104bd8:	8b 75 0c             	mov    0xc(%ebp),%esi
80104bdb:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104bde:	39 c6                	cmp    %eax,%esi
80104be0:	73 2e                	jae    80104c10 <memmove+0x40>
80104be2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104be5:	39 c8                	cmp    %ecx,%eax
80104be7:	73 27                	jae    80104c10 <memmove+0x40>
80104be9:	85 db                	test   %ebx,%ebx
80104beb:	8d 53 ff             	lea    -0x1(%ebx),%edx
80104bee:	74 17                	je     80104c07 <memmove+0x37>
80104bf0:	29 d9                	sub    %ebx,%ecx
80104bf2:	89 cb                	mov    %ecx,%ebx
80104bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bf8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104bfc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104bff:	83 ea 01             	sub    $0x1,%edx
80104c02:	83 fa ff             	cmp    $0xffffffff,%edx
80104c05:	75 f1                	jne    80104bf8 <memmove+0x28>
80104c07:	5b                   	pop    %ebx
80104c08:	5e                   	pop    %esi
80104c09:	5d                   	pop    %ebp
80104c0a:	c3                   	ret    
80104c0b:	90                   	nop
80104c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c10:	31 d2                	xor    %edx,%edx
80104c12:	85 db                	test   %ebx,%ebx
80104c14:	74 f1                	je     80104c07 <memmove+0x37>
80104c16:	8d 76 00             	lea    0x0(%esi),%esi
80104c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104c20:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104c24:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104c27:	83 c2 01             	add    $0x1,%edx
80104c2a:	39 d3                	cmp    %edx,%ebx
80104c2c:	75 f2                	jne    80104c20 <memmove+0x50>
80104c2e:	5b                   	pop    %ebx
80104c2f:	5e                   	pop    %esi
80104c30:	5d                   	pop    %ebp
80104c31:	c3                   	ret    
80104c32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c40 <memcpy>:
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	5d                   	pop    %ebp
80104c44:	eb 8a                	jmp    80104bd0 <memmove>
80104c46:	8d 76 00             	lea    0x0(%esi),%esi
80104c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c50 <strncmp>:
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	57                   	push   %edi
80104c54:	56                   	push   %esi
80104c55:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104c58:	53                   	push   %ebx
80104c59:	8b 7d 08             	mov    0x8(%ebp),%edi
80104c5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80104c5f:	85 c9                	test   %ecx,%ecx
80104c61:	74 37                	je     80104c9a <strncmp+0x4a>
80104c63:	0f b6 17             	movzbl (%edi),%edx
80104c66:	0f b6 1e             	movzbl (%esi),%ebx
80104c69:	84 d2                	test   %dl,%dl
80104c6b:	74 3f                	je     80104cac <strncmp+0x5c>
80104c6d:	38 d3                	cmp    %dl,%bl
80104c6f:	75 3b                	jne    80104cac <strncmp+0x5c>
80104c71:	8d 47 01             	lea    0x1(%edi),%eax
80104c74:	01 cf                	add    %ecx,%edi
80104c76:	eb 1b                	jmp    80104c93 <strncmp+0x43>
80104c78:	90                   	nop
80104c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c80:	0f b6 10             	movzbl (%eax),%edx
80104c83:	84 d2                	test   %dl,%dl
80104c85:	74 21                	je     80104ca8 <strncmp+0x58>
80104c87:	0f b6 19             	movzbl (%ecx),%ebx
80104c8a:	83 c0 01             	add    $0x1,%eax
80104c8d:	89 ce                	mov    %ecx,%esi
80104c8f:	38 da                	cmp    %bl,%dl
80104c91:	75 19                	jne    80104cac <strncmp+0x5c>
80104c93:	39 c7                	cmp    %eax,%edi
80104c95:	8d 4e 01             	lea    0x1(%esi),%ecx
80104c98:	75 e6                	jne    80104c80 <strncmp+0x30>
80104c9a:	5b                   	pop    %ebx
80104c9b:	31 c0                	xor    %eax,%eax
80104c9d:	5e                   	pop    %esi
80104c9e:	5f                   	pop    %edi
80104c9f:	5d                   	pop    %ebp
80104ca0:	c3                   	ret    
80104ca1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ca8:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
80104cac:	0f b6 c2             	movzbl %dl,%eax
80104caf:	29 d8                	sub    %ebx,%eax
80104cb1:	5b                   	pop    %ebx
80104cb2:	5e                   	pop    %esi
80104cb3:	5f                   	pop    %edi
80104cb4:	5d                   	pop    %ebp
80104cb5:	c3                   	ret    
80104cb6:	8d 76 00             	lea    0x0(%esi),%esi
80104cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cc0 <strncpy>:
80104cc0:	55                   	push   %ebp
80104cc1:	89 e5                	mov    %esp,%ebp
80104cc3:	56                   	push   %esi
80104cc4:	53                   	push   %ebx
80104cc5:	8b 45 08             	mov    0x8(%ebp),%eax
80104cc8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104ccb:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104cce:	89 c2                	mov    %eax,%edx
80104cd0:	eb 19                	jmp    80104ceb <strncpy+0x2b>
80104cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cd8:	83 c3 01             	add    $0x1,%ebx
80104cdb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104cdf:	83 c2 01             	add    $0x1,%edx
80104ce2:	84 c9                	test   %cl,%cl
80104ce4:	88 4a ff             	mov    %cl,-0x1(%edx)
80104ce7:	74 09                	je     80104cf2 <strncpy+0x32>
80104ce9:	89 f1                	mov    %esi,%ecx
80104ceb:	85 c9                	test   %ecx,%ecx
80104ced:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104cf0:	7f e6                	jg     80104cd8 <strncpy+0x18>
80104cf2:	31 c9                	xor    %ecx,%ecx
80104cf4:	85 f6                	test   %esi,%esi
80104cf6:	7e 17                	jle    80104d0f <strncpy+0x4f>
80104cf8:	90                   	nop
80104cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d00:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104d04:	89 f3                	mov    %esi,%ebx
80104d06:	83 c1 01             	add    $0x1,%ecx
80104d09:	29 cb                	sub    %ecx,%ebx
80104d0b:	85 db                	test   %ebx,%ebx
80104d0d:	7f f1                	jg     80104d00 <strncpy+0x40>
80104d0f:	5b                   	pop    %ebx
80104d10:	5e                   	pop    %esi
80104d11:	5d                   	pop    %ebp
80104d12:	c3                   	ret    
80104d13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d20 <safestrcpy>:
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
80104d23:	56                   	push   %esi
80104d24:	53                   	push   %ebx
80104d25:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d28:	8b 45 08             	mov    0x8(%ebp),%eax
80104d2b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d2e:	85 c9                	test   %ecx,%ecx
80104d30:	7e 26                	jle    80104d58 <safestrcpy+0x38>
80104d32:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104d36:	89 c1                	mov    %eax,%ecx
80104d38:	eb 17                	jmp    80104d51 <safestrcpy+0x31>
80104d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d40:	83 c2 01             	add    $0x1,%edx
80104d43:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104d47:	83 c1 01             	add    $0x1,%ecx
80104d4a:	84 db                	test   %bl,%bl
80104d4c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104d4f:	74 04                	je     80104d55 <safestrcpy+0x35>
80104d51:	39 f2                	cmp    %esi,%edx
80104d53:	75 eb                	jne    80104d40 <safestrcpy+0x20>
80104d55:	c6 01 00             	movb   $0x0,(%ecx)
80104d58:	5b                   	pop    %ebx
80104d59:	5e                   	pop    %esi
80104d5a:	5d                   	pop    %ebp
80104d5b:	c3                   	ret    
80104d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d60 <strlen>:
80104d60:	55                   	push   %ebp
80104d61:	31 c0                	xor    %eax,%eax
80104d63:	89 e5                	mov    %esp,%ebp
80104d65:	8b 55 08             	mov    0x8(%ebp),%edx
80104d68:	80 3a 00             	cmpb   $0x0,(%edx)
80104d6b:	74 0c                	je     80104d79 <strlen+0x19>
80104d6d:	8d 76 00             	lea    0x0(%esi),%esi
80104d70:	83 c0 01             	add    $0x1,%eax
80104d73:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104d77:	75 f7                	jne    80104d70 <strlen+0x10>
80104d79:	5d                   	pop    %ebp
80104d7a:	c3                   	ret    

80104d7b <swtch>:
80104d7b:	8b 44 24 04          	mov    0x4(%esp),%eax
80104d7f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104d83:	55                   	push   %ebp
80104d84:	53                   	push   %ebx
80104d85:	56                   	push   %esi
80104d86:	57                   	push   %edi
80104d87:	89 20                	mov    %esp,(%eax)
80104d89:	89 d4                	mov    %edx,%esp
80104d8b:	5f                   	pop    %edi
80104d8c:	5e                   	pop    %esi
80104d8d:	5b                   	pop    %ebx
80104d8e:	5d                   	pop    %ebp
80104d8f:	c3                   	ret    

80104d90 <fetchint>:
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int fetchint(uint addr, int *ip)
{
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	53                   	push   %ebx
80104d94:	83 ec 04             	sub    $0x4,%esp
80104d97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104d9a:	e8 21 ed ff ff       	call   80103ac0 <myproc>

  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80104d9f:	8b 00                	mov    (%eax),%eax
80104da1:	39 d8                	cmp    %ebx,%eax
80104da3:	76 1b                	jbe    80104dc0 <fetchint+0x30>
80104da5:	8d 53 04             	lea    0x4(%ebx),%edx
80104da8:	39 d0                	cmp    %edx,%eax
80104daa:	72 14                	jb     80104dc0 <fetchint+0x30>
    return -1;
  *ip = *(int *)(addr);
80104dac:	8b 45 0c             	mov    0xc(%ebp),%eax
80104daf:	8b 13                	mov    (%ebx),%edx
80104db1:	89 10                	mov    %edx,(%eax)
  return 0;
80104db3:	31 c0                	xor    %eax,%eax
}
80104db5:	83 c4 04             	add    $0x4,%esp
80104db8:	5b                   	pop    %ebx
80104db9:	5d                   	pop    %ebp
80104dba:	c3                   	ret    
80104dbb:	90                   	nop
80104dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if (addr >= curproc->sz || addr + 4 > curproc->sz)
    return -1;
80104dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104dc5:	eb ee                	jmp    80104db5 <fetchint+0x25>
80104dc7:	89 f6                	mov    %esi,%esi
80104dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dd0 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int fetchstr(uint addr, char **pp)
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	53                   	push   %ebx
80104dd4:	83 ec 04             	sub    $0x4,%esp
80104dd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104dda:	e8 e1 ec ff ff       	call   80103ac0 <myproc>

  if (addr >= curproc->sz)
80104ddf:	39 18                	cmp    %ebx,(%eax)
80104de1:	76 29                	jbe    80104e0c <fetchstr+0x3c>
    return -1;
  *pp = (char *)addr;
80104de3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104de6:	89 da                	mov    %ebx,%edx
80104de8:	89 19                	mov    %ebx,(%ecx)
  ep = (char *)curproc->sz;
80104dea:	8b 00                	mov    (%eax),%eax
  for (s = *pp; s < ep; s++)
80104dec:	39 c3                	cmp    %eax,%ebx
80104dee:	73 1c                	jae    80104e0c <fetchstr+0x3c>
  {
    if (*s == 0)
80104df0:	80 3b 00             	cmpb   $0x0,(%ebx)
80104df3:	75 10                	jne    80104e05 <fetchstr+0x35>
80104df5:	eb 29                	jmp    80104e20 <fetchstr+0x50>
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104e00:	80 3a 00             	cmpb   $0x0,(%edx)
80104e03:	74 1b                	je     80104e20 <fetchstr+0x50>

  if (addr >= curproc->sz)
    return -1;
  *pp = (char *)addr;
  ep = (char *)curproc->sz;
  for (s = *pp; s < ep; s++)
80104e05:	83 c2 01             	add    $0x1,%edx
80104e08:	39 d0                	cmp    %edx,%eax
80104e0a:	77 f4                	ja     80104e00 <fetchstr+0x30>
  {
    if (*s == 0)
      return s - *pp;
  }
  return -1;
}
80104e0c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if (addr >= curproc->sz)
    return -1;
80104e0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  {
    if (*s == 0)
      return s - *pp;
  }
  return -1;
}
80104e14:	5b                   	pop    %ebx
80104e15:	5d                   	pop    %ebp
80104e16:	c3                   	ret    
80104e17:	89 f6                	mov    %esi,%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104e20:	83 c4 04             	add    $0x4,%esp
  *pp = (char *)addr;
  ep = (char *)curproc->sz;
  for (s = *pp; s < ep; s++)
  {
    if (*s == 0)
      return s - *pp;
80104e23:	89 d0                	mov    %edx,%eax
80104e25:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104e27:	5b                   	pop    %ebx
80104e28:	5d                   	pop    %ebp
80104e29:	c3                   	ret    
80104e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e30 <argint>:

// Fetch the nth 32-bit system call argument.
int argint(int n, int *ip)
{
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	56                   	push   %esi
80104e34:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80104e35:	e8 86 ec ff ff       	call   80103ac0 <myproc>
80104e3a:	8b 40 18             	mov    0x18(%eax),%eax
80104e3d:	8b 55 08             	mov    0x8(%ebp),%edx
80104e40:	8b 40 44             	mov    0x44(%eax),%eax
80104e43:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80104e46:	e8 75 ec ff ff       	call   80103ac0 <myproc>

  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80104e4b:	8b 00                	mov    (%eax),%eax
}

// Fetch the nth 32-bit system call argument.
int argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
80104e4d:	8d 73 04             	lea    0x4(%ebx),%esi
// Fetch the int at addr from the current process.
int fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if (addr >= curproc->sz || addr + 4 > curproc->sz)
80104e50:	39 c6                	cmp    %eax,%esi
80104e52:	73 1c                	jae    80104e70 <argint+0x40>
80104e54:	8d 53 08             	lea    0x8(%ebx),%edx
80104e57:	39 d0                	cmp    %edx,%eax
80104e59:	72 15                	jb     80104e70 <argint+0x40>
    return -1;
  *ip = *(int *)(addr);
80104e5b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e5e:	8b 53 04             	mov    0x4(%ebx),%edx
80104e61:	89 10                	mov    %edx,(%eax)
  return 0;
80104e63:	31 c0                	xor    %eax,%eax

// Fetch the nth 32-bit system call argument.
int argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4 * n, ip);
}
80104e65:	5b                   	pop    %ebx
80104e66:	5e                   	pop    %esi
80104e67:	5d                   	pop    %ebp
80104e68:	c3                   	ret    
80104e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
int fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if (addr >= curproc->sz || addr + 4 > curproc->sz)
    return -1;
80104e70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e75:	eb ee                	jmp    80104e65 <argint+0x35>
80104e77:	89 f6                	mov    %esi,%esi
80104e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e80 <argptr>:

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int argptr(int n, char **pp, int size)
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	56                   	push   %esi
80104e84:	53                   	push   %ebx
80104e85:	83 ec 10             	sub    $0x10,%esp
80104e88:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104e8b:	e8 30 ec ff ff       	call   80103ac0 <myproc>
80104e90:	89 c6                	mov    %eax,%esi

  if (argint(n, &i) < 0)
80104e92:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e95:	83 ec 08             	sub    $0x8,%esp
80104e98:	50                   	push   %eax
80104e99:	ff 75 08             	pushl  0x8(%ebp)
80104e9c:	e8 8f ff ff ff       	call   80104e30 <argint>
    return -1;
  if (size < 0 || (uint)i >= curproc->sz || (uint)i + size > curproc->sz)
80104ea1:	c1 e8 1f             	shr    $0x1f,%eax
80104ea4:	83 c4 10             	add    $0x10,%esp
80104ea7:	84 c0                	test   %al,%al
80104ea9:	75 2d                	jne    80104ed8 <argptr+0x58>
80104eab:	89 d8                	mov    %ebx,%eax
80104ead:	c1 e8 1f             	shr    $0x1f,%eax
80104eb0:	84 c0                	test   %al,%al
80104eb2:	75 24                	jne    80104ed8 <argptr+0x58>
80104eb4:	8b 16                	mov    (%esi),%edx
80104eb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104eb9:	39 c2                	cmp    %eax,%edx
80104ebb:	76 1b                	jbe    80104ed8 <argptr+0x58>
80104ebd:	01 c3                	add    %eax,%ebx
80104ebf:	39 da                	cmp    %ebx,%edx
80104ec1:	72 15                	jb     80104ed8 <argptr+0x58>
    return -1;
  *pp = (char *)i;
80104ec3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104ec6:	89 02                	mov    %eax,(%edx)
  return 0;
80104ec8:	31 c0                	xor    %eax,%eax
}
80104eca:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ecd:	5b                   	pop    %ebx
80104ece:	5e                   	pop    %esi
80104ecf:	5d                   	pop    %ebp
80104ed0:	c3                   	ret    
80104ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();

  if (argint(n, &i) < 0)
    return -1;
  if (size < 0 || (uint)i >= curproc->sz || (uint)i + size > curproc->sz)
    return -1;
80104ed8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104edd:	eb eb                	jmp    80104eca <argptr+0x4a>
80104edf:	90                   	nop

80104ee0 <argstr>:
// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int argstr(int n, char **pp)
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if (argint(n, &addr) < 0)
80104ee6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ee9:	50                   	push   %eax
80104eea:	ff 75 08             	pushl  0x8(%ebp)
80104eed:	e8 3e ff ff ff       	call   80104e30 <argint>
80104ef2:	83 c4 10             	add    $0x10,%esp
80104ef5:	85 c0                	test   %eax,%eax
80104ef7:	78 17                	js     80104f10 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104ef9:	83 ec 08             	sub    $0x8,%esp
80104efc:	ff 75 0c             	pushl  0xc(%ebp)
80104eff:	ff 75 f4             	pushl  -0xc(%ebp)
80104f02:	e8 c9 fe ff ff       	call   80104dd0 <fetchstr>
80104f07:	83 c4 10             	add    $0x10,%esp
}
80104f0a:	c9                   	leave  
80104f0b:	c3                   	ret    
80104f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
// between this check and being used by the kernel.)
int argstr(int n, char **pp)
{
  int addr;
  if (argint(n, &addr) < 0)
    return -1;
80104f10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104f15:	c9                   	leave  
80104f16:	c3                   	ret    
80104f17:	89 f6                	mov    %esi,%esi
80104f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f20 <syscall>:
    [SYS_printstack] sys_printstack,
    [SYS_thread_create] sys_thread_create,
};

void syscall(void)
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	56                   	push   %esi
80104f24:	53                   	push   %ebx
80104f25:	83 ec 10             	sub    $0x10,%esp
  int num;
  struct proc *curproc = myproc();
80104f28:	e8 93 eb ff ff       	call   80103ac0 <myproc>
  num = curproc->tf->eax;
80104f2d:	8b 58 18             	mov    0x18(%eax),%ebx
};

void syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104f30:	89 c6                	mov    %eax,%esi
  num = curproc->tf->eax;
80104f32:	8b 43 1c             	mov    0x1c(%ebx),%eax
  if (num == 22)
80104f35:	83 f8 16             	cmp    $0x16,%eax
80104f38:	74 36                	je     80104f70 <syscall+0x50>
  {
    int arg = 0;
    argint(0, &arg);
    curproc->tf->eax = sys_incNum(arg);
  }
  else if (num > 0 && num < NELEM(syscalls) && syscalls[num])
80104f3a:	8d 50 ff             	lea    -0x1(%eax),%edx
80104f3d:	83 fa 18             	cmp    $0x18,%edx
80104f40:	77 1e                	ja     80104f60 <syscall+0x40>
80104f42:	8b 04 85 80 7e 10 80 	mov    -0x7fef8180(,%eax,4),%eax
80104f49:	85 c0                	test   %eax,%eax
80104f4b:	74 13                	je     80104f60 <syscall+0x40>
  {
    curproc->tf->eax = syscalls[num]();
80104f4d:	ff d0                	call   *%eax
80104f4f:	89 43 1c             	mov    %eax,0x1c(%ebx)
  }
  else
  {
    curproc->tf->eax = -1;
  }
}
80104f52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f55:	5b                   	pop    %ebx
80104f56:	5e                   	pop    %esi
80104f57:	5d                   	pop    %ebp
80104f58:	c3                   	ret    
80104f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  {
    curproc->tf->eax = syscalls[num]();
  }
  else
  {
    curproc->tf->eax = -1;
80104f60:	c7 43 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%ebx)
  }
}
80104f67:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f6a:	5b                   	pop    %ebx
80104f6b:	5e                   	pop    %esi
80104f6c:	5d                   	pop    %ebp
80104f6d:	c3                   	ret    
80104f6e:	66 90                	xchg   %ax,%ax
  struct proc *curproc = myproc();
  num = curproc->tf->eax;
  if (num == 22)
  {
    int arg = 0;
    argint(0, &arg);
80104f70:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f73:	83 ec 08             	sub    $0x8,%esp
  int num;
  struct proc *curproc = myproc();
  num = curproc->tf->eax;
  if (num == 22)
  {
    int arg = 0;
80104f76:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    argint(0, &arg);
80104f7d:	50                   	push   %eax
80104f7e:	6a 00                	push   $0x0
80104f80:	e8 ab fe ff ff       	call   80104e30 <argint>
    curproc->tf->eax = sys_incNum(arg);
80104f85:	58                   	pop    %eax
80104f86:	8b 5e 18             	mov    0x18(%esi),%ebx
80104f89:	ff 75 f4             	pushl  -0xc(%ebp)
80104f8c:	e8 af 0d 00 00       	call   80105d40 <sys_incNum>
80104f91:	83 c4 10             	add    $0x10,%esp
80104f94:	89 43 1c             	mov    %eax,0x1c(%ebx)
80104f97:	eb ce                	jmp    80104f67 <syscall+0x47>
80104f99:	66 90                	xchg   %ax,%ax
80104f9b:	66 90                	xchg   %ax,%ax
80104f9d:	66 90                	xchg   %ax,%ax
80104f9f:	90                   	nop

80104fa0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	57                   	push   %edi
80104fa4:	56                   	push   %esi
80104fa5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104fa6:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104fa9:	83 ec 44             	sub    $0x44,%esp
80104fac:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104faf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104fb2:	56                   	push   %esi
80104fb3:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104fb4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104fb7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104fba:	e8 51 d2 ff ff       	call   80102210 <nameiparent>
80104fbf:	83 c4 10             	add    $0x10,%esp
80104fc2:	85 c0                	test   %eax,%eax
80104fc4:	0f 84 f6 00 00 00    	je     801050c0 <create+0x120>
    return 0;
  ilock(dp);
80104fca:	83 ec 0c             	sub    $0xc,%esp
80104fcd:	89 c7                	mov    %eax,%edi
80104fcf:	50                   	push   %eax
80104fd0:	e8 cb c9 ff ff       	call   801019a0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104fd5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104fd8:	83 c4 0c             	add    $0xc,%esp
80104fdb:	50                   	push   %eax
80104fdc:	56                   	push   %esi
80104fdd:	57                   	push   %edi
80104fde:	e8 ed ce ff ff       	call   80101ed0 <dirlookup>
80104fe3:	83 c4 10             	add    $0x10,%esp
80104fe6:	85 c0                	test   %eax,%eax
80104fe8:	89 c3                	mov    %eax,%ebx
80104fea:	74 54                	je     80105040 <create+0xa0>
    iunlockput(dp);
80104fec:	83 ec 0c             	sub    $0xc,%esp
80104fef:	57                   	push   %edi
80104ff0:	e8 3b cc ff ff       	call   80101c30 <iunlockput>
    ilock(ip);
80104ff5:	89 1c 24             	mov    %ebx,(%esp)
80104ff8:	e8 a3 c9 ff ff       	call   801019a0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104ffd:	83 c4 10             	add    $0x10,%esp
80105000:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80105005:	75 19                	jne    80105020 <create+0x80>
80105007:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
8010500c:	89 d8                	mov    %ebx,%eax
8010500e:	75 10                	jne    80105020 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105010:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105013:	5b                   	pop    %ebx
80105014:	5e                   	pop    %esi
80105015:	5f                   	pop    %edi
80105016:	5d                   	pop    %ebp
80105017:	c3                   	ret    
80105018:	90                   	nop
80105019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80105020:	83 ec 0c             	sub    $0xc,%esp
80105023:	53                   	push   %ebx
80105024:	e8 07 cc ff ff       	call   80101c30 <iunlockput>
    return 0;
80105029:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010502c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
8010502f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105031:	5b                   	pop    %ebx
80105032:	5e                   	pop    %esi
80105033:	5f                   	pop    %edi
80105034:	5d                   	pop    %ebp
80105035:	c3                   	ret    
80105036:	8d 76 00             	lea    0x0(%esi),%esi
80105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105040:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105044:	83 ec 08             	sub    $0x8,%esp
80105047:	50                   	push   %eax
80105048:	ff 37                	pushl  (%edi)
8010504a:	e8 e1 c7 ff ff       	call   80101830 <ialloc>
8010504f:	83 c4 10             	add    $0x10,%esp
80105052:	85 c0                	test   %eax,%eax
80105054:	89 c3                	mov    %eax,%ebx
80105056:	0f 84 cc 00 00 00    	je     80105128 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
8010505c:	83 ec 0c             	sub    $0xc,%esp
8010505f:	50                   	push   %eax
80105060:	e8 3b c9 ff ff       	call   801019a0 <ilock>
  ip->major = major;
80105065:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105069:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
8010506d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105071:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80105075:	b8 01 00 00 00       	mov    $0x1,%eax
8010507a:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
8010507e:	89 1c 24             	mov    %ebx,(%esp)
80105081:	e8 6a c8 ff ff       	call   801018f0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80105086:	83 c4 10             	add    $0x10,%esp
80105089:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010508e:	74 40                	je     801050d0 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105090:	83 ec 04             	sub    $0x4,%esp
80105093:	ff 73 04             	pushl  0x4(%ebx)
80105096:	56                   	push   %esi
80105097:	57                   	push   %edi
80105098:	e8 93 d0 ff ff       	call   80102130 <dirlink>
8010509d:	83 c4 10             	add    $0x10,%esp
801050a0:	85 c0                	test   %eax,%eax
801050a2:	78 77                	js     8010511b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
801050a4:	83 ec 0c             	sub    $0xc,%esp
801050a7:	57                   	push   %edi
801050a8:	e8 83 cb ff ff       	call   80101c30 <iunlockput>

  return ip;
801050ad:	83 c4 10             	add    $0x10,%esp
}
801050b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
801050b3:	89 d8                	mov    %ebx,%eax
}
801050b5:	5b                   	pop    %ebx
801050b6:	5e                   	pop    %esi
801050b7:	5f                   	pop    %edi
801050b8:	5d                   	pop    %ebp
801050b9:	c3                   	ret    
801050ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
801050c0:	31 c0                	xor    %eax,%eax
801050c2:	e9 49 ff ff ff       	jmp    80105010 <create+0x70>
801050c7:	89 f6                	mov    %esi,%esi
801050c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
801050d0:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
801050d5:	83 ec 0c             	sub    $0xc,%esp
801050d8:	57                   	push   %edi
801050d9:	e8 12 c8 ff ff       	call   801018f0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801050de:	83 c4 0c             	add    $0xc,%esp
801050e1:	ff 73 04             	pushl  0x4(%ebx)
801050e4:	68 04 7f 10 80       	push   $0x80107f04
801050e9:	53                   	push   %ebx
801050ea:	e8 41 d0 ff ff       	call   80102130 <dirlink>
801050ef:	83 c4 10             	add    $0x10,%esp
801050f2:	85 c0                	test   %eax,%eax
801050f4:	78 18                	js     8010510e <create+0x16e>
801050f6:	83 ec 04             	sub    $0x4,%esp
801050f9:	ff 77 04             	pushl  0x4(%edi)
801050fc:	68 03 7f 10 80       	push   $0x80107f03
80105101:	53                   	push   %ebx
80105102:	e8 29 d0 ff ff       	call   80102130 <dirlink>
80105107:	83 c4 10             	add    $0x10,%esp
8010510a:	85 c0                	test   %eax,%eax
8010510c:	79 82                	jns    80105090 <create+0xf0>
      panic("create dots");
8010510e:	83 ec 0c             	sub    $0xc,%esp
80105111:	68 f7 7e 10 80       	push   $0x80107ef7
80105116:	e8 55 b2 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
8010511b:	83 ec 0c             	sub    $0xc,%esp
8010511e:	68 06 7f 10 80       	push   $0x80107f06
80105123:	e8 48 b2 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80105128:	83 ec 0c             	sub    $0xc,%esp
8010512b:	68 e8 7e 10 80       	push   $0x80107ee8
80105130:	e8 3b b2 ff ff       	call   80100370 <panic>
80105135:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105140 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	56                   	push   %esi
80105144:	53                   	push   %ebx
80105145:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105147:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
8010514a:	89 d3                	mov    %edx,%ebx
8010514c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010514f:	50                   	push   %eax
80105150:	6a 00                	push   $0x0
80105152:	e8 d9 fc ff ff       	call   80104e30 <argint>
80105157:	83 c4 10             	add    $0x10,%esp
8010515a:	85 c0                	test   %eax,%eax
8010515c:	78 32                	js     80105190 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010515e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105162:	77 2c                	ja     80105190 <argfd.constprop.0+0x50>
80105164:	e8 57 e9 ff ff       	call   80103ac0 <myproc>
80105169:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010516c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105170:	85 c0                	test   %eax,%eax
80105172:	74 1c                	je     80105190 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80105174:	85 f6                	test   %esi,%esi
80105176:	74 02                	je     8010517a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105178:	89 16                	mov    %edx,(%esi)
  if(pf)
8010517a:	85 db                	test   %ebx,%ebx
8010517c:	74 22                	je     801051a0 <argfd.constprop.0+0x60>
    *pf = f;
8010517e:	89 03                	mov    %eax,(%ebx)
  return 0;
80105180:	31 c0                	xor    %eax,%eax
}
80105182:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105185:	5b                   	pop    %ebx
80105186:	5e                   	pop    %esi
80105187:	5d                   	pop    %ebp
80105188:	c3                   	ret    
80105189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105190:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80105193:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80105198:	5b                   	pop    %ebx
80105199:	5e                   	pop    %esi
8010519a:	5d                   	pop    %ebp
8010519b:	c3                   	ret    
8010519c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
801051a0:	31 c0                	xor    %eax,%eax
801051a2:	eb de                	jmp    80105182 <argfd.constprop.0+0x42>
801051a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801051b0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
801051b0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801051b1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
801051b3:	89 e5                	mov    %esp,%ebp
801051b5:	56                   	push   %esi
801051b6:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801051b7:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
801051ba:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801051bd:	e8 7e ff ff ff       	call   80105140 <argfd.constprop.0>
801051c2:	85 c0                	test   %eax,%eax
801051c4:	78 1a                	js     801051e0 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801051c6:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
801051c8:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801051cb:	e8 f0 e8 ff ff       	call   80103ac0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801051d0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801051d4:	85 d2                	test   %edx,%edx
801051d6:	74 18                	je     801051f0 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801051d8:	83 c3 01             	add    $0x1,%ebx
801051db:	83 fb 10             	cmp    $0x10,%ebx
801051de:	75 f0                	jne    801051d0 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
801051e0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
801051e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
801051e8:	5b                   	pop    %ebx
801051e9:	5e                   	pop    %esi
801051ea:	5d                   	pop    %ebp
801051eb:	c3                   	ret    
801051ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801051f0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
801051f4:	83 ec 0c             	sub    $0xc,%esp
801051f7:	ff 75 f4             	pushl  -0xc(%ebp)
801051fa:	e8 11 bf ff ff       	call   80101110 <filedup>
  return fd;
801051ff:	83 c4 10             	add    $0x10,%esp
}
80105202:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80105205:	89 d8                	mov    %ebx,%eax
}
80105207:	5b                   	pop    %ebx
80105208:	5e                   	pop    %esi
80105209:	5d                   	pop    %ebp
8010520a:	c3                   	ret    
8010520b:	90                   	nop
8010520c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105210 <sys_read>:

int
sys_read(void)
{
80105210:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105211:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80105213:	89 e5                	mov    %esp,%ebp
80105215:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105218:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010521b:	e8 20 ff ff ff       	call   80105140 <argfd.constprop.0>
80105220:	85 c0                	test   %eax,%eax
80105222:	78 4c                	js     80105270 <sys_read+0x60>
80105224:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105227:	83 ec 08             	sub    $0x8,%esp
8010522a:	50                   	push   %eax
8010522b:	6a 02                	push   $0x2
8010522d:	e8 fe fb ff ff       	call   80104e30 <argint>
80105232:	83 c4 10             	add    $0x10,%esp
80105235:	85 c0                	test   %eax,%eax
80105237:	78 37                	js     80105270 <sys_read+0x60>
80105239:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010523c:	83 ec 04             	sub    $0x4,%esp
8010523f:	ff 75 f0             	pushl  -0x10(%ebp)
80105242:	50                   	push   %eax
80105243:	6a 01                	push   $0x1
80105245:	e8 36 fc ff ff       	call   80104e80 <argptr>
8010524a:	83 c4 10             	add    $0x10,%esp
8010524d:	85 c0                	test   %eax,%eax
8010524f:	78 1f                	js     80105270 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80105251:	83 ec 04             	sub    $0x4,%esp
80105254:	ff 75 f0             	pushl  -0x10(%ebp)
80105257:	ff 75 f4             	pushl  -0xc(%ebp)
8010525a:	ff 75 ec             	pushl  -0x14(%ebp)
8010525d:	e8 1e c0 ff ff       	call   80101280 <fileread>
80105262:	83 c4 10             	add    $0x10,%esp
}
80105265:	c9                   	leave  
80105266:	c3                   	ret    
80105267:	89 f6                	mov    %esi,%esi
80105269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80105270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80105275:	c9                   	leave  
80105276:	c3                   	ret    
80105277:	89 f6                	mov    %esi,%esi
80105279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105280 <sys_write>:

int
sys_write(void)
{
80105280:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105281:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80105283:	89 e5                	mov    %esp,%ebp
80105285:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105288:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010528b:	e8 b0 fe ff ff       	call   80105140 <argfd.constprop.0>
80105290:	85 c0                	test   %eax,%eax
80105292:	78 4c                	js     801052e0 <sys_write+0x60>
80105294:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105297:	83 ec 08             	sub    $0x8,%esp
8010529a:	50                   	push   %eax
8010529b:	6a 02                	push   $0x2
8010529d:	e8 8e fb ff ff       	call   80104e30 <argint>
801052a2:	83 c4 10             	add    $0x10,%esp
801052a5:	85 c0                	test   %eax,%eax
801052a7:	78 37                	js     801052e0 <sys_write+0x60>
801052a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052ac:	83 ec 04             	sub    $0x4,%esp
801052af:	ff 75 f0             	pushl  -0x10(%ebp)
801052b2:	50                   	push   %eax
801052b3:	6a 01                	push   $0x1
801052b5:	e8 c6 fb ff ff       	call   80104e80 <argptr>
801052ba:	83 c4 10             	add    $0x10,%esp
801052bd:	85 c0                	test   %eax,%eax
801052bf:	78 1f                	js     801052e0 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
801052c1:	83 ec 04             	sub    $0x4,%esp
801052c4:	ff 75 f0             	pushl  -0x10(%ebp)
801052c7:	ff 75 f4             	pushl  -0xc(%ebp)
801052ca:	ff 75 ec             	pushl  -0x14(%ebp)
801052cd:	e8 3e c0 ff ff       	call   80101310 <filewrite>
801052d2:	83 c4 10             	add    $0x10,%esp
}
801052d5:	c9                   	leave  
801052d6:	c3                   	ret    
801052d7:	89 f6                	mov    %esi,%esi
801052d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
801052e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
801052e5:	c9                   	leave  
801052e6:	c3                   	ret    
801052e7:	89 f6                	mov    %esi,%esi
801052e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052f0 <sys_close>:

int
sys_close(void)
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
801052f3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
801052f6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801052f9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052fc:	e8 3f fe ff ff       	call   80105140 <argfd.constprop.0>
80105301:	85 c0                	test   %eax,%eax
80105303:	78 2b                	js     80105330 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80105305:	e8 b6 e7 ff ff       	call   80103ac0 <myproc>
8010530a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010530d:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80105310:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105317:	00 
  fileclose(f);
80105318:	ff 75 f4             	pushl  -0xc(%ebp)
8010531b:	e8 40 be ff ff       	call   80101160 <fileclose>
  return 0;
80105320:	83 c4 10             	add    $0x10,%esp
80105323:	31 c0                	xor    %eax,%eax
}
80105325:	c9                   	leave  
80105326:	c3                   	ret    
80105327:	89 f6                	mov    %esi,%esi
80105329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80105330:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80105335:	c9                   	leave  
80105336:	c3                   	ret    
80105337:	89 f6                	mov    %esi,%esi
80105339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105340 <sys_fstat>:

int
sys_fstat(void)
{
80105340:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105341:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80105343:	89 e5                	mov    %esp,%ebp
80105345:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105348:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010534b:	e8 f0 fd ff ff       	call   80105140 <argfd.constprop.0>
80105350:	85 c0                	test   %eax,%eax
80105352:	78 2c                	js     80105380 <sys_fstat+0x40>
80105354:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105357:	83 ec 04             	sub    $0x4,%esp
8010535a:	6a 14                	push   $0x14
8010535c:	50                   	push   %eax
8010535d:	6a 01                	push   $0x1
8010535f:	e8 1c fb ff ff       	call   80104e80 <argptr>
80105364:	83 c4 10             	add    $0x10,%esp
80105367:	85 c0                	test   %eax,%eax
80105369:	78 15                	js     80105380 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
8010536b:	83 ec 08             	sub    $0x8,%esp
8010536e:	ff 75 f4             	pushl  -0xc(%ebp)
80105371:	ff 75 f0             	pushl  -0x10(%ebp)
80105374:	e8 b7 be ff ff       	call   80101230 <filestat>
80105379:	83 c4 10             	add    $0x10,%esp
}
8010537c:	c9                   	leave  
8010537d:	c3                   	ret    
8010537e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80105380:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80105385:	c9                   	leave  
80105386:	c3                   	ret    
80105387:	89 f6                	mov    %esi,%esi
80105389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105390 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	57                   	push   %edi
80105394:	56                   	push   %esi
80105395:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105396:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105399:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010539c:	50                   	push   %eax
8010539d:	6a 00                	push   $0x0
8010539f:	e8 3c fb ff ff       	call   80104ee0 <argstr>
801053a4:	83 c4 10             	add    $0x10,%esp
801053a7:	85 c0                	test   %eax,%eax
801053a9:	0f 88 fb 00 00 00    	js     801054aa <sys_link+0x11a>
801053af:	8d 45 d0             	lea    -0x30(%ebp),%eax
801053b2:	83 ec 08             	sub    $0x8,%esp
801053b5:	50                   	push   %eax
801053b6:	6a 01                	push   $0x1
801053b8:	e8 23 fb ff ff       	call   80104ee0 <argstr>
801053bd:	83 c4 10             	add    $0x10,%esp
801053c0:	85 c0                	test   %eax,%eax
801053c2:	0f 88 e2 00 00 00    	js     801054aa <sys_link+0x11a>
    return -1;

  begin_op();
801053c8:	e8 b3 da ff ff       	call   80102e80 <begin_op>
  if((ip = namei(old)) == 0){
801053cd:	83 ec 0c             	sub    $0xc,%esp
801053d0:	ff 75 d4             	pushl  -0x2c(%ebp)
801053d3:	e8 18 ce ff ff       	call   801021f0 <namei>
801053d8:	83 c4 10             	add    $0x10,%esp
801053db:	85 c0                	test   %eax,%eax
801053dd:	89 c3                	mov    %eax,%ebx
801053df:	0f 84 f3 00 00 00    	je     801054d8 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
801053e5:	83 ec 0c             	sub    $0xc,%esp
801053e8:	50                   	push   %eax
801053e9:	e8 b2 c5 ff ff       	call   801019a0 <ilock>
  if(ip->type == T_DIR){
801053ee:	83 c4 10             	add    $0x10,%esp
801053f1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053f6:	0f 84 c4 00 00 00    	je     801054c0 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
801053fc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105401:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105404:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80105407:	53                   	push   %ebx
80105408:	e8 e3 c4 ff ff       	call   801018f0 <iupdate>
  iunlock(ip);
8010540d:	89 1c 24             	mov    %ebx,(%esp)
80105410:	e8 6b c6 ff ff       	call   80101a80 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105415:	58                   	pop    %eax
80105416:	5a                   	pop    %edx
80105417:	57                   	push   %edi
80105418:	ff 75 d0             	pushl  -0x30(%ebp)
8010541b:	e8 f0 cd ff ff       	call   80102210 <nameiparent>
80105420:	83 c4 10             	add    $0x10,%esp
80105423:	85 c0                	test   %eax,%eax
80105425:	89 c6                	mov    %eax,%esi
80105427:	74 5b                	je     80105484 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80105429:	83 ec 0c             	sub    $0xc,%esp
8010542c:	50                   	push   %eax
8010542d:	e8 6e c5 ff ff       	call   801019a0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105432:	83 c4 10             	add    $0x10,%esp
80105435:	8b 03                	mov    (%ebx),%eax
80105437:	39 06                	cmp    %eax,(%esi)
80105439:	75 3d                	jne    80105478 <sys_link+0xe8>
8010543b:	83 ec 04             	sub    $0x4,%esp
8010543e:	ff 73 04             	pushl  0x4(%ebx)
80105441:	57                   	push   %edi
80105442:	56                   	push   %esi
80105443:	e8 e8 cc ff ff       	call   80102130 <dirlink>
80105448:	83 c4 10             	add    $0x10,%esp
8010544b:	85 c0                	test   %eax,%eax
8010544d:	78 29                	js     80105478 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
8010544f:	83 ec 0c             	sub    $0xc,%esp
80105452:	56                   	push   %esi
80105453:	e8 d8 c7 ff ff       	call   80101c30 <iunlockput>
  iput(ip);
80105458:	89 1c 24             	mov    %ebx,(%esp)
8010545b:	e8 70 c6 ff ff       	call   80101ad0 <iput>

  end_op();
80105460:	e8 8b da ff ff       	call   80102ef0 <end_op>

  return 0;
80105465:	83 c4 10             	add    $0x10,%esp
80105468:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
8010546a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010546d:	5b                   	pop    %ebx
8010546e:	5e                   	pop    %esi
8010546f:	5f                   	pop    %edi
80105470:	5d                   	pop    %ebp
80105471:	c3                   	ret    
80105472:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80105478:	83 ec 0c             	sub    $0xc,%esp
8010547b:	56                   	push   %esi
8010547c:	e8 af c7 ff ff       	call   80101c30 <iunlockput>
    goto bad;
80105481:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80105484:	83 ec 0c             	sub    $0xc,%esp
80105487:	53                   	push   %ebx
80105488:	e8 13 c5 ff ff       	call   801019a0 <ilock>
  ip->nlink--;
8010548d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105492:	89 1c 24             	mov    %ebx,(%esp)
80105495:	e8 56 c4 ff ff       	call   801018f0 <iupdate>
  iunlockput(ip);
8010549a:	89 1c 24             	mov    %ebx,(%esp)
8010549d:	e8 8e c7 ff ff       	call   80101c30 <iunlockput>
  end_op();
801054a2:	e8 49 da ff ff       	call   80102ef0 <end_op>
  return -1;
801054a7:	83 c4 10             	add    $0x10,%esp
}
801054aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
801054ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054b2:	5b                   	pop    %ebx
801054b3:	5e                   	pop    %esi
801054b4:	5f                   	pop    %edi
801054b5:	5d                   	pop    %ebp
801054b6:	c3                   	ret    
801054b7:	89 f6                	mov    %esi,%esi
801054b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
801054c0:	83 ec 0c             	sub    $0xc,%esp
801054c3:	53                   	push   %ebx
801054c4:	e8 67 c7 ff ff       	call   80101c30 <iunlockput>
    end_op();
801054c9:	e8 22 da ff ff       	call   80102ef0 <end_op>
    return -1;
801054ce:	83 c4 10             	add    $0x10,%esp
801054d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054d6:	eb 92                	jmp    8010546a <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
801054d8:	e8 13 da ff ff       	call   80102ef0 <end_op>
    return -1;
801054dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054e2:	eb 86                	jmp    8010546a <sys_link+0xda>
801054e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801054f0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	57                   	push   %edi
801054f4:	56                   	push   %esi
801054f5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801054f6:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
801054f9:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801054fc:	50                   	push   %eax
801054fd:	6a 00                	push   $0x0
801054ff:	e8 dc f9 ff ff       	call   80104ee0 <argstr>
80105504:	83 c4 10             	add    $0x10,%esp
80105507:	85 c0                	test   %eax,%eax
80105509:	0f 88 82 01 00 00    	js     80105691 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
8010550f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80105512:	e8 69 d9 ff ff       	call   80102e80 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105517:	83 ec 08             	sub    $0x8,%esp
8010551a:	53                   	push   %ebx
8010551b:	ff 75 c0             	pushl  -0x40(%ebp)
8010551e:	e8 ed cc ff ff       	call   80102210 <nameiparent>
80105523:	83 c4 10             	add    $0x10,%esp
80105526:	85 c0                	test   %eax,%eax
80105528:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010552b:	0f 84 6a 01 00 00    	je     8010569b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80105531:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105534:	83 ec 0c             	sub    $0xc,%esp
80105537:	56                   	push   %esi
80105538:	e8 63 c4 ff ff       	call   801019a0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010553d:	58                   	pop    %eax
8010553e:	5a                   	pop    %edx
8010553f:	68 04 7f 10 80       	push   $0x80107f04
80105544:	53                   	push   %ebx
80105545:	e8 66 c9 ff ff       	call   80101eb0 <namecmp>
8010554a:	83 c4 10             	add    $0x10,%esp
8010554d:	85 c0                	test   %eax,%eax
8010554f:	0f 84 fc 00 00 00    	je     80105651 <sys_unlink+0x161>
80105555:	83 ec 08             	sub    $0x8,%esp
80105558:	68 03 7f 10 80       	push   $0x80107f03
8010555d:	53                   	push   %ebx
8010555e:	e8 4d c9 ff ff       	call   80101eb0 <namecmp>
80105563:	83 c4 10             	add    $0x10,%esp
80105566:	85 c0                	test   %eax,%eax
80105568:	0f 84 e3 00 00 00    	je     80105651 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010556e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105571:	83 ec 04             	sub    $0x4,%esp
80105574:	50                   	push   %eax
80105575:	53                   	push   %ebx
80105576:	56                   	push   %esi
80105577:	e8 54 c9 ff ff       	call   80101ed0 <dirlookup>
8010557c:	83 c4 10             	add    $0x10,%esp
8010557f:	85 c0                	test   %eax,%eax
80105581:	89 c3                	mov    %eax,%ebx
80105583:	0f 84 c8 00 00 00    	je     80105651 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80105589:	83 ec 0c             	sub    $0xc,%esp
8010558c:	50                   	push   %eax
8010558d:	e8 0e c4 ff ff       	call   801019a0 <ilock>

  if(ip->nlink < 1)
80105592:	83 c4 10             	add    $0x10,%esp
80105595:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010559a:	0f 8e 24 01 00 00    	jle    801056c4 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801055a0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801055a5:	8d 75 d8             	lea    -0x28(%ebp),%esi
801055a8:	74 66                	je     80105610 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801055aa:	83 ec 04             	sub    $0x4,%esp
801055ad:	6a 10                	push   $0x10
801055af:	6a 00                	push   $0x0
801055b1:	56                   	push   %esi
801055b2:	e8 69 f5 ff ff       	call   80104b20 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801055b7:	6a 10                	push   $0x10
801055b9:	ff 75 c4             	pushl  -0x3c(%ebp)
801055bc:	56                   	push   %esi
801055bd:	ff 75 b4             	pushl  -0x4c(%ebp)
801055c0:	e8 bb c7 ff ff       	call   80101d80 <writei>
801055c5:	83 c4 20             	add    $0x20,%esp
801055c8:	83 f8 10             	cmp    $0x10,%eax
801055cb:	0f 85 e6 00 00 00    	jne    801056b7 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801055d1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801055d6:	0f 84 9c 00 00 00    	je     80105678 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801055dc:	83 ec 0c             	sub    $0xc,%esp
801055df:	ff 75 b4             	pushl  -0x4c(%ebp)
801055e2:	e8 49 c6 ff ff       	call   80101c30 <iunlockput>

  ip->nlink--;
801055e7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801055ec:	89 1c 24             	mov    %ebx,(%esp)
801055ef:	e8 fc c2 ff ff       	call   801018f0 <iupdate>
  iunlockput(ip);
801055f4:	89 1c 24             	mov    %ebx,(%esp)
801055f7:	e8 34 c6 ff ff       	call   80101c30 <iunlockput>

  end_op();
801055fc:	e8 ef d8 ff ff       	call   80102ef0 <end_op>

  return 0;
80105601:	83 c4 10             	add    $0x10,%esp
80105604:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105606:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105609:	5b                   	pop    %ebx
8010560a:	5e                   	pop    %esi
8010560b:	5f                   	pop    %edi
8010560c:	5d                   	pop    %ebp
8010560d:	c3                   	ret    
8010560e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105610:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105614:	76 94                	jbe    801055aa <sys_unlink+0xba>
80105616:	bf 20 00 00 00       	mov    $0x20,%edi
8010561b:	eb 0f                	jmp    8010562c <sys_unlink+0x13c>
8010561d:	8d 76 00             	lea    0x0(%esi),%esi
80105620:	83 c7 10             	add    $0x10,%edi
80105623:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105626:	0f 83 7e ff ff ff    	jae    801055aa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010562c:	6a 10                	push   $0x10
8010562e:	57                   	push   %edi
8010562f:	56                   	push   %esi
80105630:	53                   	push   %ebx
80105631:	e8 4a c6 ff ff       	call   80101c80 <readi>
80105636:	83 c4 10             	add    $0x10,%esp
80105639:	83 f8 10             	cmp    $0x10,%eax
8010563c:	75 6c                	jne    801056aa <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010563e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105643:	74 db                	je     80105620 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105645:	83 ec 0c             	sub    $0xc,%esp
80105648:	53                   	push   %ebx
80105649:	e8 e2 c5 ff ff       	call   80101c30 <iunlockput>
    goto bad;
8010564e:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105651:	83 ec 0c             	sub    $0xc,%esp
80105654:	ff 75 b4             	pushl  -0x4c(%ebp)
80105657:	e8 d4 c5 ff ff       	call   80101c30 <iunlockput>
  end_op();
8010565c:	e8 8f d8 ff ff       	call   80102ef0 <end_op>
  return -1;
80105661:	83 c4 10             	add    $0x10,%esp
}
80105664:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80105667:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010566c:	5b                   	pop    %ebx
8010566d:	5e                   	pop    %esi
8010566e:	5f                   	pop    %edi
8010566f:	5d                   	pop    %ebp
80105670:	c3                   	ret    
80105671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105678:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010567b:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
8010567e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105683:	50                   	push   %eax
80105684:	e8 67 c2 ff ff       	call   801018f0 <iupdate>
80105689:	83 c4 10             	add    $0x10,%esp
8010568c:	e9 4b ff ff ff       	jmp    801055dc <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105691:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105696:	e9 6b ff ff ff       	jmp    80105606 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010569b:	e8 50 d8 ff ff       	call   80102ef0 <end_op>
    return -1;
801056a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056a5:	e9 5c ff ff ff       	jmp    80105606 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
801056aa:	83 ec 0c             	sub    $0xc,%esp
801056ad:	68 28 7f 10 80       	push   $0x80107f28
801056b2:	e8 b9 ac ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
801056b7:	83 ec 0c             	sub    $0xc,%esp
801056ba:	68 3a 7f 10 80       	push   $0x80107f3a
801056bf:	e8 ac ac ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
801056c4:	83 ec 0c             	sub    $0xc,%esp
801056c7:	68 16 7f 10 80       	push   $0x80107f16
801056cc:	e8 9f ac ff ff       	call   80100370 <panic>
801056d1:	eb 0d                	jmp    801056e0 <sys_open>
801056d3:	90                   	nop
801056d4:	90                   	nop
801056d5:	90                   	nop
801056d6:	90                   	nop
801056d7:	90                   	nop
801056d8:	90                   	nop
801056d9:	90                   	nop
801056da:	90                   	nop
801056db:	90                   	nop
801056dc:	90                   	nop
801056dd:	90                   	nop
801056de:	90                   	nop
801056df:	90                   	nop

801056e0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	57                   	push   %edi
801056e4:	56                   	push   %esi
801056e5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801056e6:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
801056e9:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801056ec:	50                   	push   %eax
801056ed:	6a 00                	push   $0x0
801056ef:	e8 ec f7 ff ff       	call   80104ee0 <argstr>
801056f4:	83 c4 10             	add    $0x10,%esp
801056f7:	85 c0                	test   %eax,%eax
801056f9:	0f 88 9e 00 00 00    	js     8010579d <sys_open+0xbd>
801056ff:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105702:	83 ec 08             	sub    $0x8,%esp
80105705:	50                   	push   %eax
80105706:	6a 01                	push   $0x1
80105708:	e8 23 f7 ff ff       	call   80104e30 <argint>
8010570d:	83 c4 10             	add    $0x10,%esp
80105710:	85 c0                	test   %eax,%eax
80105712:	0f 88 85 00 00 00    	js     8010579d <sys_open+0xbd>
    return -1;

  begin_op();
80105718:	e8 63 d7 ff ff       	call   80102e80 <begin_op>

  if(omode & O_CREATE){
8010571d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105721:	0f 85 89 00 00 00    	jne    801057b0 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105727:	83 ec 0c             	sub    $0xc,%esp
8010572a:	ff 75 e0             	pushl  -0x20(%ebp)
8010572d:	e8 be ca ff ff       	call   801021f0 <namei>
80105732:	83 c4 10             	add    $0x10,%esp
80105735:	85 c0                	test   %eax,%eax
80105737:	89 c6                	mov    %eax,%esi
80105739:	0f 84 8e 00 00 00    	je     801057cd <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010573f:	83 ec 0c             	sub    $0xc,%esp
80105742:	50                   	push   %eax
80105743:	e8 58 c2 ff ff       	call   801019a0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105748:	83 c4 10             	add    $0x10,%esp
8010574b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105750:	0f 84 d2 00 00 00    	je     80105828 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105756:	e8 45 b9 ff ff       	call   801010a0 <filealloc>
8010575b:	85 c0                	test   %eax,%eax
8010575d:	89 c7                	mov    %eax,%edi
8010575f:	74 2b                	je     8010578c <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105761:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105763:	e8 58 e3 ff ff       	call   80103ac0 <myproc>
80105768:	90                   	nop
80105769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105770:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105774:	85 d2                	test   %edx,%edx
80105776:	74 68                	je     801057e0 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105778:	83 c3 01             	add    $0x1,%ebx
8010577b:	83 fb 10             	cmp    $0x10,%ebx
8010577e:	75 f0                	jne    80105770 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105780:	83 ec 0c             	sub    $0xc,%esp
80105783:	57                   	push   %edi
80105784:	e8 d7 b9 ff ff       	call   80101160 <fileclose>
80105789:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010578c:	83 ec 0c             	sub    $0xc,%esp
8010578f:	56                   	push   %esi
80105790:	e8 9b c4 ff ff       	call   80101c30 <iunlockput>
    end_op();
80105795:	e8 56 d7 ff ff       	call   80102ef0 <end_op>
    return -1;
8010579a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010579d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
801057a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801057a5:	5b                   	pop    %ebx
801057a6:	5e                   	pop    %esi
801057a7:	5f                   	pop    %edi
801057a8:	5d                   	pop    %ebp
801057a9:	c3                   	ret    
801057aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801057b0:	83 ec 0c             	sub    $0xc,%esp
801057b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801057b6:	31 c9                	xor    %ecx,%ecx
801057b8:	6a 00                	push   $0x0
801057ba:	ba 02 00 00 00       	mov    $0x2,%edx
801057bf:	e8 dc f7 ff ff       	call   80104fa0 <create>
    if(ip == 0){
801057c4:	83 c4 10             	add    $0x10,%esp
801057c7:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801057c9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801057cb:	75 89                	jne    80105756 <sys_open+0x76>
      end_op();
801057cd:	e8 1e d7 ff ff       	call   80102ef0 <end_op>
      return -1;
801057d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057d7:	eb 43                	jmp    8010581c <sys_open+0x13c>
801057d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801057e0:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801057e3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801057e7:	56                   	push   %esi
801057e8:	e8 93 c2 ff ff       	call   80101a80 <iunlock>
  end_op();
801057ed:	e8 fe d6 ff ff       	call   80102ef0 <end_op>

  f->type = FD_INODE;
801057f2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801057f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801057fb:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
801057fe:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105801:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105808:	89 d0                	mov    %edx,%eax
8010580a:	83 e0 01             	and    $0x1,%eax
8010580d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105810:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105813:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105816:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
8010581a:	89 d8                	mov    %ebx,%eax
}
8010581c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010581f:	5b                   	pop    %ebx
80105820:	5e                   	pop    %esi
80105821:	5f                   	pop    %edi
80105822:	5d                   	pop    %ebp
80105823:	c3                   	ret    
80105824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105828:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010582b:	85 c9                	test   %ecx,%ecx
8010582d:	0f 84 23 ff ff ff    	je     80105756 <sys_open+0x76>
80105833:	e9 54 ff ff ff       	jmp    8010578c <sys_open+0xac>
80105838:	90                   	nop
80105839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105840 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105846:	e8 35 d6 ff ff       	call   80102e80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010584b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010584e:	83 ec 08             	sub    $0x8,%esp
80105851:	50                   	push   %eax
80105852:	6a 00                	push   $0x0
80105854:	e8 87 f6 ff ff       	call   80104ee0 <argstr>
80105859:	83 c4 10             	add    $0x10,%esp
8010585c:	85 c0                	test   %eax,%eax
8010585e:	78 30                	js     80105890 <sys_mkdir+0x50>
80105860:	83 ec 0c             	sub    $0xc,%esp
80105863:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105866:	31 c9                	xor    %ecx,%ecx
80105868:	6a 00                	push   $0x0
8010586a:	ba 01 00 00 00       	mov    $0x1,%edx
8010586f:	e8 2c f7 ff ff       	call   80104fa0 <create>
80105874:	83 c4 10             	add    $0x10,%esp
80105877:	85 c0                	test   %eax,%eax
80105879:	74 15                	je     80105890 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010587b:	83 ec 0c             	sub    $0xc,%esp
8010587e:	50                   	push   %eax
8010587f:	e8 ac c3 ff ff       	call   80101c30 <iunlockput>
  end_op();
80105884:	e8 67 d6 ff ff       	call   80102ef0 <end_op>
  return 0;
80105889:	83 c4 10             	add    $0x10,%esp
8010588c:	31 c0                	xor    %eax,%eax
}
8010588e:	c9                   	leave  
8010588f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105890:	e8 5b d6 ff ff       	call   80102ef0 <end_op>
    return -1;
80105895:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010589a:	c9                   	leave  
8010589b:	c3                   	ret    
8010589c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058a0 <sys_mknod>:

int
sys_mknod(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801058a6:	e8 d5 d5 ff ff       	call   80102e80 <begin_op>
  if((argstr(0, &path)) < 0 ||
801058ab:	8d 45 ec             	lea    -0x14(%ebp),%eax
801058ae:	83 ec 08             	sub    $0x8,%esp
801058b1:	50                   	push   %eax
801058b2:	6a 00                	push   $0x0
801058b4:	e8 27 f6 ff ff       	call   80104ee0 <argstr>
801058b9:	83 c4 10             	add    $0x10,%esp
801058bc:	85 c0                	test   %eax,%eax
801058be:	78 60                	js     80105920 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801058c0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058c3:	83 ec 08             	sub    $0x8,%esp
801058c6:	50                   	push   %eax
801058c7:	6a 01                	push   $0x1
801058c9:	e8 62 f5 ff ff       	call   80104e30 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
801058ce:	83 c4 10             	add    $0x10,%esp
801058d1:	85 c0                	test   %eax,%eax
801058d3:	78 4b                	js     80105920 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801058d5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058d8:	83 ec 08             	sub    $0x8,%esp
801058db:	50                   	push   %eax
801058dc:	6a 02                	push   $0x2
801058de:	e8 4d f5 ff ff       	call   80104e30 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801058e3:	83 c4 10             	add    $0x10,%esp
801058e6:	85 c0                	test   %eax,%eax
801058e8:	78 36                	js     80105920 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801058ea:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801058ee:	83 ec 0c             	sub    $0xc,%esp
801058f1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801058f5:	ba 03 00 00 00       	mov    $0x3,%edx
801058fa:	50                   	push   %eax
801058fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801058fe:	e8 9d f6 ff ff       	call   80104fa0 <create>
80105903:	83 c4 10             	add    $0x10,%esp
80105906:	85 c0                	test   %eax,%eax
80105908:	74 16                	je     80105920 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010590a:	83 ec 0c             	sub    $0xc,%esp
8010590d:	50                   	push   %eax
8010590e:	e8 1d c3 ff ff       	call   80101c30 <iunlockput>
  end_op();
80105913:	e8 d8 d5 ff ff       	call   80102ef0 <end_op>
  return 0;
80105918:	83 c4 10             	add    $0x10,%esp
8010591b:	31 c0                	xor    %eax,%eax
}
8010591d:	c9                   	leave  
8010591e:	c3                   	ret    
8010591f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105920:	e8 cb d5 ff ff       	call   80102ef0 <end_op>
    return -1;
80105925:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010592a:	c9                   	leave  
8010592b:	c3                   	ret    
8010592c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105930 <sys_chdir>:

int
sys_chdir(void)
{
80105930:	55                   	push   %ebp
80105931:	89 e5                	mov    %esp,%ebp
80105933:	56                   	push   %esi
80105934:	53                   	push   %ebx
80105935:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105938:	e8 83 e1 ff ff       	call   80103ac0 <myproc>
8010593d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010593f:	e8 3c d5 ff ff       	call   80102e80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105944:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105947:	83 ec 08             	sub    $0x8,%esp
8010594a:	50                   	push   %eax
8010594b:	6a 00                	push   $0x0
8010594d:	e8 8e f5 ff ff       	call   80104ee0 <argstr>
80105952:	83 c4 10             	add    $0x10,%esp
80105955:	85 c0                	test   %eax,%eax
80105957:	78 77                	js     801059d0 <sys_chdir+0xa0>
80105959:	83 ec 0c             	sub    $0xc,%esp
8010595c:	ff 75 f4             	pushl  -0xc(%ebp)
8010595f:	e8 8c c8 ff ff       	call   801021f0 <namei>
80105964:	83 c4 10             	add    $0x10,%esp
80105967:	85 c0                	test   %eax,%eax
80105969:	89 c3                	mov    %eax,%ebx
8010596b:	74 63                	je     801059d0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010596d:	83 ec 0c             	sub    $0xc,%esp
80105970:	50                   	push   %eax
80105971:	e8 2a c0 ff ff       	call   801019a0 <ilock>
  if(ip->type != T_DIR){
80105976:	83 c4 10             	add    $0x10,%esp
80105979:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010597e:	75 30                	jne    801059b0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105980:	83 ec 0c             	sub    $0xc,%esp
80105983:	53                   	push   %ebx
80105984:	e8 f7 c0 ff ff       	call   80101a80 <iunlock>
  iput(curproc->cwd);
80105989:	58                   	pop    %eax
8010598a:	ff 76 68             	pushl  0x68(%esi)
8010598d:	e8 3e c1 ff ff       	call   80101ad0 <iput>
  end_op();
80105992:	e8 59 d5 ff ff       	call   80102ef0 <end_op>
  curproc->cwd = ip;
80105997:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010599a:	83 c4 10             	add    $0x10,%esp
8010599d:	31 c0                	xor    %eax,%eax
}
8010599f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059a2:	5b                   	pop    %ebx
801059a3:	5e                   	pop    %esi
801059a4:	5d                   	pop    %ebp
801059a5:	c3                   	ret    
801059a6:	8d 76 00             	lea    0x0(%esi),%esi
801059a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
801059b0:	83 ec 0c             	sub    $0xc,%esp
801059b3:	53                   	push   %ebx
801059b4:	e8 77 c2 ff ff       	call   80101c30 <iunlockput>
    end_op();
801059b9:	e8 32 d5 ff ff       	call   80102ef0 <end_op>
    return -1;
801059be:	83 c4 10             	add    $0x10,%esp
801059c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059c6:	eb d7                	jmp    8010599f <sys_chdir+0x6f>
801059c8:	90                   	nop
801059c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
801059d0:	e8 1b d5 ff ff       	call   80102ef0 <end_op>
    return -1;
801059d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059da:	eb c3                	jmp    8010599f <sys_chdir+0x6f>
801059dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059e0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
801059e0:	55                   	push   %ebp
801059e1:	89 e5                	mov    %esp,%ebp
801059e3:	57                   	push   %edi
801059e4:	56                   	push   %esi
801059e5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801059e6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
801059ec:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801059f2:	50                   	push   %eax
801059f3:	6a 00                	push   $0x0
801059f5:	e8 e6 f4 ff ff       	call   80104ee0 <argstr>
801059fa:	83 c4 10             	add    $0x10,%esp
801059fd:	85 c0                	test   %eax,%eax
801059ff:	78 7f                	js     80105a80 <sys_exec+0xa0>
80105a01:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105a07:	83 ec 08             	sub    $0x8,%esp
80105a0a:	50                   	push   %eax
80105a0b:	6a 01                	push   $0x1
80105a0d:	e8 1e f4 ff ff       	call   80104e30 <argint>
80105a12:	83 c4 10             	add    $0x10,%esp
80105a15:	85 c0                	test   %eax,%eax
80105a17:	78 67                	js     80105a80 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105a19:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105a1f:	83 ec 04             	sub    $0x4,%esp
80105a22:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105a28:	68 80 00 00 00       	push   $0x80
80105a2d:	6a 00                	push   $0x0
80105a2f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105a35:	50                   	push   %eax
80105a36:	31 db                	xor    %ebx,%ebx
80105a38:	e8 e3 f0 ff ff       	call   80104b20 <memset>
80105a3d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105a40:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105a46:	83 ec 08             	sub    $0x8,%esp
80105a49:	57                   	push   %edi
80105a4a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
80105a4d:	50                   	push   %eax
80105a4e:	e8 3d f3 ff ff       	call   80104d90 <fetchint>
80105a53:	83 c4 10             	add    $0x10,%esp
80105a56:	85 c0                	test   %eax,%eax
80105a58:	78 26                	js     80105a80 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
80105a5a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105a60:	85 c0                	test   %eax,%eax
80105a62:	74 2c                	je     80105a90 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105a64:	83 ec 08             	sub    $0x8,%esp
80105a67:	56                   	push   %esi
80105a68:	50                   	push   %eax
80105a69:	e8 62 f3 ff ff       	call   80104dd0 <fetchstr>
80105a6e:	83 c4 10             	add    $0x10,%esp
80105a71:	85 c0                	test   %eax,%eax
80105a73:	78 0b                	js     80105a80 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105a75:	83 c3 01             	add    $0x1,%ebx
80105a78:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
80105a7b:	83 fb 20             	cmp    $0x20,%ebx
80105a7e:	75 c0                	jne    80105a40 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105a80:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105a83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105a88:	5b                   	pop    %ebx
80105a89:	5e                   	pop    %esi
80105a8a:	5f                   	pop    %edi
80105a8b:	5d                   	pop    %ebp
80105a8c:	c3                   	ret    
80105a8d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105a90:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105a96:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105a99:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105aa0:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105aa4:	50                   	push   %eax
80105aa5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105aab:	e8 70 b2 ff ff       	call   80100d20 <exec>
80105ab0:	83 c4 10             	add    $0x10,%esp
}
80105ab3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ab6:	5b                   	pop    %ebx
80105ab7:	5e                   	pop    %esi
80105ab8:	5f                   	pop    %edi
80105ab9:	5d                   	pop    %ebp
80105aba:	c3                   	ret    
80105abb:	90                   	nop
80105abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ac0 <sys_pipe>:

int
sys_pipe(void)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	57                   	push   %edi
80105ac4:	56                   	push   %esi
80105ac5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105ac6:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105ac9:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105acc:	6a 08                	push   $0x8
80105ace:	50                   	push   %eax
80105acf:	6a 00                	push   $0x0
80105ad1:	e8 aa f3 ff ff       	call   80104e80 <argptr>
80105ad6:	83 c4 10             	add    $0x10,%esp
80105ad9:	85 c0                	test   %eax,%eax
80105adb:	78 4a                	js     80105b27 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105add:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ae0:	83 ec 08             	sub    $0x8,%esp
80105ae3:	50                   	push   %eax
80105ae4:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ae7:	50                   	push   %eax
80105ae8:	e8 33 da ff ff       	call   80103520 <pipealloc>
80105aed:	83 c4 10             	add    $0x10,%esp
80105af0:	85 c0                	test   %eax,%eax
80105af2:	78 33                	js     80105b27 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105af4:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105af6:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105af9:	e8 c2 df ff ff       	call   80103ac0 <myproc>
80105afe:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105b00:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105b04:	85 f6                	test   %esi,%esi
80105b06:	74 30                	je     80105b38 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105b08:	83 c3 01             	add    $0x1,%ebx
80105b0b:	83 fb 10             	cmp    $0x10,%ebx
80105b0e:	75 f0                	jne    80105b00 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105b10:	83 ec 0c             	sub    $0xc,%esp
80105b13:	ff 75 e0             	pushl  -0x20(%ebp)
80105b16:	e8 45 b6 ff ff       	call   80101160 <fileclose>
    fileclose(wf);
80105b1b:	58                   	pop    %eax
80105b1c:	ff 75 e4             	pushl  -0x1c(%ebp)
80105b1f:	e8 3c b6 ff ff       	call   80101160 <fileclose>
    return -1;
80105b24:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105b27:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
80105b2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105b2f:	5b                   	pop    %ebx
80105b30:	5e                   	pop    %esi
80105b31:	5f                   	pop    %edi
80105b32:	5d                   	pop    %ebp
80105b33:	c3                   	ret    
80105b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105b38:	8d 73 08             	lea    0x8(%ebx),%esi
80105b3b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105b3f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105b42:	e8 79 df ff ff       	call   80103ac0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80105b47:	31 d2                	xor    %edx,%edx
80105b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105b50:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105b54:	85 c9                	test   %ecx,%ecx
80105b56:	74 18                	je     80105b70 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105b58:	83 c2 01             	add    $0x1,%edx
80105b5b:	83 fa 10             	cmp    $0x10,%edx
80105b5e:	75 f0                	jne    80105b50 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105b60:	e8 5b df ff ff       	call   80103ac0 <myproc>
80105b65:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105b6c:	00 
80105b6d:	eb a1                	jmp    80105b10 <sys_pipe+0x50>
80105b6f:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105b70:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105b74:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105b77:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105b79:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105b7c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
80105b7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105b82:	31 c0                	xor    %eax,%eax
}
80105b84:	5b                   	pop    %ebx
80105b85:	5e                   	pop    %esi
80105b86:	5f                   	pop    %edi
80105b87:	5d                   	pop    %ebp
80105b88:	c3                   	ret    
80105b89:	66 90                	xchg   %ax,%ax
80105b8b:	66 90                	xchg   %ax,%ax
80105b8d:	66 90                	xchg   %ax,%ax
80105b8f:	90                   	nop

80105b90 <sys_fork>:
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int sys_fork(void)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105b93:	5d                   	pop    %ebp
#include "mmu.h"
#include "proc.h"

int sys_fork(void)
{
  return fork();
80105b94:	e9 c7 e0 ff ff       	jmp    80103c60 <fork>
80105b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ba0 <sys_exit>:
}

int sys_exit(void)
{
80105ba0:	55                   	push   %ebp
80105ba1:	89 e5                	mov    %esp,%ebp
80105ba3:	83 ec 08             	sub    $0x8,%esp
  exit();
80105ba6:	e8 45 e3 ff ff       	call   80103ef0 <exit>
  return 0; // not reached
}
80105bab:	31 c0                	xor    %eax,%eax
80105bad:	c9                   	leave  
80105bae:	c3                   	ret    
80105baf:	90                   	nop

80105bb0 <sys_wait>:

int sys_wait(void)
{
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105bb3:	5d                   	pop    %ebp
  return 0; // not reached
}

int sys_wait(void)
{
  return wait();
80105bb4:	e9 77 e5 ff ff       	jmp    80104130 <wait>
80105bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105bc0 <sys_kill>:
}

int sys_kill(void)
{
80105bc0:	55                   	push   %ebp
80105bc1:	89 e5                	mov    %esp,%ebp
80105bc3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if (argint(0, &pid) < 0)
80105bc6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105bc9:	50                   	push   %eax
80105bca:	6a 00                	push   $0x0
80105bcc:	e8 5f f2 ff ff       	call   80104e30 <argint>
80105bd1:	83 c4 10             	add    $0x10,%esp
80105bd4:	85 c0                	test   %eax,%eax
80105bd6:	78 18                	js     80105bf0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105bd8:	83 ec 0c             	sub    $0xc,%esp
80105bdb:	ff 75 f4             	pushl  -0xc(%ebp)
80105bde:	e8 ad e6 ff ff       	call   80104290 <kill>
80105be3:	83 c4 10             	add    $0x10,%esp
}
80105be6:	c9                   	leave  
80105be7:	c3                   	ret    
80105be8:	90                   	nop
80105be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
int sys_kill(void)
{
  int pid;

  if (argint(0, &pid) < 0)
    return -1;
80105bf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105bf5:	c9                   	leave  
80105bf6:	c3                   	ret    
80105bf7:	89 f6                	mov    %esi,%esi
80105bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c00 <sys_getpid>:

int sys_getpid(void)
{
80105c00:	55                   	push   %ebp
80105c01:	89 e5                	mov    %esp,%ebp
80105c03:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105c06:	e8 b5 de ff ff       	call   80103ac0 <myproc>
80105c0b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105c0e:	c9                   	leave  
80105c0f:	c3                   	ret    

80105c10 <sys_sbrk>:

int sys_sbrk(void)
{
80105c10:	55                   	push   %ebp
80105c11:	89 e5                	mov    %esp,%ebp
80105c13:	53                   	push   %ebx
  int addr;
  int n;

  if (argint(0, &n) < 0)
80105c14:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
  return myproc()->pid;
}

int sys_sbrk(void)
{
80105c17:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if (argint(0, &n) < 0)
80105c1a:	50                   	push   %eax
80105c1b:	6a 00                	push   $0x0
80105c1d:	e8 0e f2 ff ff       	call   80104e30 <argint>
80105c22:	83 c4 10             	add    $0x10,%esp
80105c25:	85 c0                	test   %eax,%eax
80105c27:	78 27                	js     80105c50 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105c29:	e8 92 de ff ff       	call   80103ac0 <myproc>
  if (growproc(n) < 0)
80105c2e:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if (argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105c31:	8b 18                	mov    (%eax),%ebx
  if (growproc(n) < 0)
80105c33:	ff 75 f4             	pushl  -0xc(%ebp)
80105c36:	e8 a5 df ff ff       	call   80103be0 <growproc>
80105c3b:	83 c4 10             	add    $0x10,%esp
80105c3e:	85 c0                	test   %eax,%eax
80105c40:	78 0e                	js     80105c50 <sys_sbrk+0x40>
    return -1;
  return addr;
80105c42:	89 d8                	mov    %ebx,%eax
}
80105c44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c47:	c9                   	leave  
80105c48:	c3                   	ret    
80105c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if (argint(0, &n) < 0)
    return -1;
80105c50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c55:	eb ed                	jmp    80105c44 <sys_sbrk+0x34>
80105c57:	89 f6                	mov    %esi,%esi
80105c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c60 <sys_sleep>:
    return -1;
  return addr;
}

int sys_sleep(void)
{
80105c60:	55                   	push   %ebp
80105c61:	89 e5                	mov    %esp,%ebp
80105c63:	53                   	push   %ebx
  int n;
  uint ticks0;

  if (argint(0, &n) < 0)
80105c64:	8d 45 f4             	lea    -0xc(%ebp),%eax
    return -1;
  return addr;
}

int sys_sleep(void)
{
80105c67:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if (argint(0, &n) < 0)
80105c6a:	50                   	push   %eax
80105c6b:	6a 00                	push   $0x0
80105c6d:	e8 be f1 ff ff       	call   80104e30 <argint>
80105c72:	83 c4 10             	add    $0x10,%esp
80105c75:	85 c0                	test   %eax,%eax
80105c77:	0f 88 8a 00 00 00    	js     80105d07 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105c7d:	83 ec 0c             	sub    $0xc,%esp
80105c80:	68 20 61 11 80       	push   $0x80116120
80105c85:	e8 96 ed ff ff       	call   80104a20 <acquire>
  ticks0 = ticks;
  while (ticks - ticks0 < n)
80105c8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c8d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if (argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105c90:	8b 1d 60 69 11 80    	mov    0x80116960,%ebx
  while (ticks - ticks0 < n)
80105c96:	85 d2                	test   %edx,%edx
80105c98:	75 27                	jne    80105cc1 <sys_sleep+0x61>
80105c9a:	eb 54                	jmp    80105cf0 <sys_sleep+0x90>
80105c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (myproc()->killed)
    {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105ca0:	83 ec 08             	sub    $0x8,%esp
80105ca3:	68 20 61 11 80       	push   $0x80116120
80105ca8:	68 60 69 11 80       	push   $0x80116960
80105cad:	e8 be e3 ff ff       	call   80104070 <sleep>

  if (argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while (ticks - ticks0 < n)
80105cb2:	a1 60 69 11 80       	mov    0x80116960,%eax
80105cb7:	83 c4 10             	add    $0x10,%esp
80105cba:	29 d8                	sub    %ebx,%eax
80105cbc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105cbf:	73 2f                	jae    80105cf0 <sys_sleep+0x90>
  {
    if (myproc()->killed)
80105cc1:	e8 fa dd ff ff       	call   80103ac0 <myproc>
80105cc6:	8b 40 24             	mov    0x24(%eax),%eax
80105cc9:	85 c0                	test   %eax,%eax
80105ccb:	74 d3                	je     80105ca0 <sys_sleep+0x40>
    {
      release(&tickslock);
80105ccd:	83 ec 0c             	sub    $0xc,%esp
80105cd0:	68 20 61 11 80       	push   $0x80116120
80105cd5:	e8 f6 ed ff ff       	call   80104ad0 <release>
      return -1;
80105cda:	83 c4 10             	add    $0x10,%esp
80105cdd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105ce2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ce5:	c9                   	leave  
80105ce6:	c3                   	ret    
80105ce7:	89 f6                	mov    %esi,%esi
80105ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105cf0:	83 ec 0c             	sub    $0xc,%esp
80105cf3:	68 20 61 11 80       	push   $0x80116120
80105cf8:	e8 d3 ed ff ff       	call   80104ad0 <release>
  return 0;
80105cfd:	83 c4 10             	add    $0x10,%esp
80105d00:	31 c0                	xor    %eax,%eax
}
80105d02:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d05:	c9                   	leave  
80105d06:	c3                   	ret    
{
  int n;
  uint ticks0;

  if (argint(0, &n) < 0)
    return -1;
80105d07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d0c:	eb d4                	jmp    80105ce2 <sys_sleep+0x82>
80105d0e:	66 90                	xchg   %ax,%ax

80105d10 <sys_uptime>:
}

// return how many clock tick interrupts have occurred
// since start.
int sys_uptime(void)
{
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	53                   	push   %ebx
80105d14:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105d17:	68 20 61 11 80       	push   $0x80116120
80105d1c:	e8 ff ec ff ff       	call   80104a20 <acquire>
  xticks = ticks;
80105d21:	8b 1d 60 69 11 80    	mov    0x80116960,%ebx
  release(&tickslock);
80105d27:	c7 04 24 20 61 11 80 	movl   $0x80116120,(%esp)
80105d2e:	e8 9d ed ff ff       	call   80104ad0 <release>
  return xticks;
}
80105d33:	89 d8                	mov    %ebx,%eax
80105d35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d38:	c9                   	leave  
80105d39:	c3                   	ret    
80105d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105d40 <sys_incNum>:

int sys_incNum(int num)
{
80105d40:	55                   	push   %ebp
80105d41:	89 e5                	mov    %esp,%ebp
80105d43:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80105d46:	e8 75 dd ff ff       	call   80103ac0 <myproc>
  cprintf("increased and print in kernel surface %d\n", curproc->tf->ebx + 1);
80105d4b:	8b 40 18             	mov    0x18(%eax),%eax
80105d4e:	83 ec 08             	sub    $0x8,%esp
80105d51:	8b 40 10             	mov    0x10(%eax),%eax
80105d54:	83 c0 01             	add    $0x1,%eax
80105d57:	50                   	push   %eax
80105d58:	68 4c 7f 10 80       	push   $0x80107f4c
80105d5d:	e8 fe a8 ff ff       	call   80100660 <cprintf>

  return 22;
}
80105d62:	b8 16 00 00 00       	mov    $0x16,%eax
80105d67:	c9                   	leave  
80105d68:	c3                   	ret    
80105d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d70 <sys_getprocs>:

int sys_getprocs()
{
80105d70:	55                   	push   %ebp
80105d71:	89 e5                	mov    %esp,%ebp
  return getprocs();
}
80105d73:	5d                   	pop    %ebp
  return 22;
}

int sys_getprocs()
{
  return getprocs();
80105d74:	e9 27 e7 ff ff       	jmp    801044a0 <getprocs>
80105d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d80 <sys_printstack>:
}

int sys_printstack()
{
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
  return printstack();
}
80105d83:	5d                   	pop    %ebp
  return getprocs();
}

int sys_printstack()
{
  return printstack();
80105d84:	e9 87 e7 ff ff       	jmp    80104510 <printstack>
80105d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d90 <sys_thread_create>:
}

int sys_thread_create()
{
80105d90:	55                   	push   %ebp
80105d91:	89 e5                	mov    %esp,%ebp
80105d93:	83 ec 1c             	sub    $0x1c,%esp
  void (*fcn)(void *), *arg, *stack;

  argptr(0, (void *)&fcn, sizeof(void (*)(void *)));
80105d96:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105d99:	6a 04                	push   $0x4
80105d9b:	50                   	push   %eax
80105d9c:	6a 00                	push   $0x0
80105d9e:	e8 dd f0 ff ff       	call   80104e80 <argptr>
  argptr(1, (void *)&arg, sizeof(void *));
80105da3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105da6:	83 c4 0c             	add    $0xc,%esp
80105da9:	6a 04                	push   $0x4
80105dab:	50                   	push   %eax
80105dac:	6a 01                	push   $0x1
80105dae:	e8 cd f0 ff ff       	call   80104e80 <argptr>
  argptr(2, (void *)&stack, sizeof(void *));
80105db3:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105db6:	83 c4 0c             	add    $0xc,%esp
80105db9:	6a 04                	push   $0x4
80105dbb:	50                   	push   %eax
80105dbc:	6a 02                	push   $0x2
80105dbe:	e8 bd f0 ff ff       	call   80104e80 <argptr>
  return thread_create(fcn, arg);
80105dc3:	58                   	pop    %eax
80105dc4:	5a                   	pop    %edx
80105dc5:	ff 75 f0             	pushl  -0x10(%ebp)
80105dc8:	ff 75 ec             	pushl  -0x14(%ebp)
80105dcb:	e8 70 e9 ff ff       	call   80104740 <thread_create>
80105dd0:	c9                   	leave  
80105dd1:	c3                   	ret    

80105dd2 <alltraps>:
80105dd2:	1e                   	push   %ds
80105dd3:	06                   	push   %es
80105dd4:	0f a0                	push   %fs
80105dd6:	0f a8                	push   %gs
80105dd8:	60                   	pusha  
80105dd9:	66 b8 10 00          	mov    $0x10,%ax
80105ddd:	8e d8                	mov    %eax,%ds
80105ddf:	8e c0                	mov    %eax,%es
80105de1:	54                   	push   %esp
80105de2:	e8 e9 00 00 00       	call   80105ed0 <trap>
80105de7:	83 c4 04             	add    $0x4,%esp

80105dea <trapret>:
80105dea:	61                   	popa   
80105deb:	0f a9                	pop    %gs
80105ded:	0f a1                	pop    %fs
80105def:	07                   	pop    %es
80105df0:	1f                   	pop    %ds
80105df1:	83 c4 08             	add    $0x8,%esp
80105df4:	cf                   	iret   
80105df5:	66 90                	xchg   %ax,%ax
80105df7:	66 90                	xchg   %ax,%ax
80105df9:	66 90                	xchg   %ax,%ax
80105dfb:	66 90                	xchg   %ax,%ax
80105dfd:	66 90                	xchg   %ax,%ax
80105dff:	90                   	nop

80105e00 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105e00:	31 c0                	xor    %eax,%eax
80105e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105e08:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105e0f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105e14:	c6 04 c5 64 61 11 80 	movb   $0x0,-0x7fee9e9c(,%eax,8)
80105e1b:	00 
80105e1c:	66 89 0c c5 62 61 11 	mov    %cx,-0x7fee9e9e(,%eax,8)
80105e23:	80 
80105e24:	c6 04 c5 65 61 11 80 	movb   $0x8e,-0x7fee9e9b(,%eax,8)
80105e2b:	8e 
80105e2c:	66 89 14 c5 60 61 11 	mov    %dx,-0x7fee9ea0(,%eax,8)
80105e33:	80 
80105e34:	c1 ea 10             	shr    $0x10,%edx
80105e37:	66 89 14 c5 66 61 11 	mov    %dx,-0x7fee9e9a(,%eax,8)
80105e3e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105e3f:	83 c0 01             	add    $0x1,%eax
80105e42:	3d 00 01 00 00       	cmp    $0x100,%eax
80105e47:	75 bf                	jne    80105e08 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105e49:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105e4a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105e4f:	89 e5                	mov    %esp,%ebp
80105e51:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105e54:	a1 08 b1 10 80       	mov    0x8010b108,%eax

  initlock(&tickslock, "time");
80105e59:	68 76 7f 10 80       	push   $0x80107f76
80105e5e:	68 20 61 11 80       	push   $0x80116120
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105e63:	66 89 15 62 63 11 80 	mov    %dx,0x80116362
80105e6a:	c6 05 64 63 11 80 00 	movb   $0x0,0x80116364
80105e71:	66 a3 60 63 11 80    	mov    %ax,0x80116360
80105e77:	c1 e8 10             	shr    $0x10,%eax
80105e7a:	c6 05 65 63 11 80 ef 	movb   $0xef,0x80116365
80105e81:	66 a3 66 63 11 80    	mov    %ax,0x80116366

  initlock(&tickslock, "time");
80105e87:	e8 34 ea ff ff       	call   801048c0 <initlock>
}
80105e8c:	83 c4 10             	add    $0x10,%esp
80105e8f:	c9                   	leave  
80105e90:	c3                   	ret    
80105e91:	eb 0d                	jmp    80105ea0 <idtinit>
80105e93:	90                   	nop
80105e94:	90                   	nop
80105e95:	90                   	nop
80105e96:	90                   	nop
80105e97:	90                   	nop
80105e98:	90                   	nop
80105e99:	90                   	nop
80105e9a:	90                   	nop
80105e9b:	90                   	nop
80105e9c:	90                   	nop
80105e9d:	90                   	nop
80105e9e:	90                   	nop
80105e9f:	90                   	nop

80105ea0 <idtinit>:

void
idtinit(void)
{
80105ea0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105ea1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105ea6:	89 e5                	mov    %esp,%ebp
80105ea8:	83 ec 10             	sub    $0x10,%esp
80105eab:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105eaf:	b8 60 61 11 80       	mov    $0x80116160,%eax
80105eb4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105eb8:	c1 e8 10             	shr    $0x10,%eax
80105ebb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105ebf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105ec2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105ec5:	c9                   	leave  
80105ec6:	c3                   	ret    
80105ec7:	89 f6                	mov    %esi,%esi
80105ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ed0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105ed0:	55                   	push   %ebp
80105ed1:	89 e5                	mov    %esp,%ebp
80105ed3:	57                   	push   %edi
80105ed4:	56                   	push   %esi
80105ed5:	53                   	push   %ebx
80105ed6:	83 ec 1c             	sub    $0x1c,%esp
80105ed9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105edc:	8b 47 30             	mov    0x30(%edi),%eax
80105edf:	83 f8 40             	cmp    $0x40,%eax
80105ee2:	0f 84 88 01 00 00    	je     80106070 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105ee8:	83 e8 20             	sub    $0x20,%eax
80105eeb:	83 f8 1f             	cmp    $0x1f,%eax
80105eee:	77 10                	ja     80105f00 <trap+0x30>
80105ef0:	ff 24 85 1c 80 10 80 	jmp    *-0x7fef7fe4(,%eax,4)
80105ef7:	89 f6                	mov    %esi,%esi
80105ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105f00:	e8 bb db ff ff       	call   80103ac0 <myproc>
80105f05:	85 c0                	test   %eax,%eax
80105f07:	0f 84 d7 01 00 00    	je     801060e4 <trap+0x214>
80105f0d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105f11:	0f 84 cd 01 00 00    	je     801060e4 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105f17:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f1a:	8b 57 38             	mov    0x38(%edi),%edx
80105f1d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105f20:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105f23:	e8 78 db ff ff       	call   80103aa0 <cpuid>
80105f28:	8b 77 34             	mov    0x34(%edi),%esi
80105f2b:	8b 5f 30             	mov    0x30(%edi),%ebx
80105f2e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105f31:	e8 8a db ff ff       	call   80103ac0 <myproc>
80105f36:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105f39:	e8 82 db ff ff       	call   80103ac0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f3e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105f41:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105f44:	51                   	push   %ecx
80105f45:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105f46:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f49:	ff 75 e4             	pushl  -0x1c(%ebp)
80105f4c:	56                   	push   %esi
80105f4d:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105f4e:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f51:	52                   	push   %edx
80105f52:	ff 70 10             	pushl  0x10(%eax)
80105f55:	68 d8 7f 10 80       	push   $0x80107fd8
80105f5a:	e8 01 a7 ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105f5f:	83 c4 20             	add    $0x20,%esp
80105f62:	e8 59 db ff ff       	call   80103ac0 <myproc>
80105f67:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105f6e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f70:	e8 4b db ff ff       	call   80103ac0 <myproc>
80105f75:	85 c0                	test   %eax,%eax
80105f77:	74 0c                	je     80105f85 <trap+0xb5>
80105f79:	e8 42 db ff ff       	call   80103ac0 <myproc>
80105f7e:	8b 50 24             	mov    0x24(%eax),%edx
80105f81:	85 d2                	test   %edx,%edx
80105f83:	75 4b                	jne    80105fd0 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105f85:	e8 36 db ff ff       	call   80103ac0 <myproc>
80105f8a:	85 c0                	test   %eax,%eax
80105f8c:	74 0b                	je     80105f99 <trap+0xc9>
80105f8e:	e8 2d db ff ff       	call   80103ac0 <myproc>
80105f93:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105f97:	74 4f                	je     80105fe8 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f99:	e8 22 db ff ff       	call   80103ac0 <myproc>
80105f9e:	85 c0                	test   %eax,%eax
80105fa0:	74 1d                	je     80105fbf <trap+0xef>
80105fa2:	e8 19 db ff ff       	call   80103ac0 <myproc>
80105fa7:	8b 40 24             	mov    0x24(%eax),%eax
80105faa:	85 c0                	test   %eax,%eax
80105fac:	74 11                	je     80105fbf <trap+0xef>
80105fae:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105fb2:	83 e0 03             	and    $0x3,%eax
80105fb5:	66 83 f8 03          	cmp    $0x3,%ax
80105fb9:	0f 84 da 00 00 00    	je     80106099 <trap+0x1c9>
    exit();
}
80105fbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fc2:	5b                   	pop    %ebx
80105fc3:	5e                   	pop    %esi
80105fc4:	5f                   	pop    %edi
80105fc5:	5d                   	pop    %ebp
80105fc6:	c3                   	ret    
80105fc7:	89 f6                	mov    %esi,%esi
80105fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105fd0:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105fd4:	83 e0 03             	and    $0x3,%eax
80105fd7:	66 83 f8 03          	cmp    $0x3,%ax
80105fdb:	75 a8                	jne    80105f85 <trap+0xb5>
    exit();
80105fdd:	e8 0e df ff ff       	call   80103ef0 <exit>
80105fe2:	eb a1                	jmp    80105f85 <trap+0xb5>
80105fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105fe8:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105fec:	75 ab                	jne    80105f99 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105fee:	e8 2d e0 ff ff       	call   80104020 <yield>
80105ff3:	eb a4                	jmp    80105f99 <trap+0xc9>
80105ff5:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105ff8:	e8 a3 da ff ff       	call   80103aa0 <cpuid>
80105ffd:	85 c0                	test   %eax,%eax
80105fff:	0f 84 ab 00 00 00    	je     801060b0 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80106005:	e8 36 ca ff ff       	call   80102a40 <lapiceoi>
    break;
8010600a:	e9 61 ff ff ff       	jmp    80105f70 <trap+0xa0>
8010600f:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106010:	e8 eb c8 ff ff       	call   80102900 <kbdintr>
    lapiceoi();
80106015:	e8 26 ca ff ff       	call   80102a40 <lapiceoi>
    break;
8010601a:	e9 51 ff ff ff       	jmp    80105f70 <trap+0xa0>
8010601f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106020:	e8 5b 02 00 00       	call   80106280 <uartintr>
    lapiceoi();
80106025:	e8 16 ca ff ff       	call   80102a40 <lapiceoi>
    break;
8010602a:	e9 41 ff ff ff       	jmp    80105f70 <trap+0xa0>
8010602f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106030:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80106034:	8b 77 38             	mov    0x38(%edi),%esi
80106037:	e8 64 da ff ff       	call   80103aa0 <cpuid>
8010603c:	56                   	push   %esi
8010603d:	53                   	push   %ebx
8010603e:	50                   	push   %eax
8010603f:	68 80 7f 10 80       	push   $0x80107f80
80106044:	e8 17 a6 ff ff       	call   80100660 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80106049:	e8 f2 c9 ff ff       	call   80102a40 <lapiceoi>
    break;
8010604e:	83 c4 10             	add    $0x10,%esp
80106051:	e9 1a ff ff ff       	jmp    80105f70 <trap+0xa0>
80106056:	8d 76 00             	lea    0x0(%esi),%esi
80106059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106060:	e8 1b c3 ff ff       	call   80102380 <ideintr>
80106065:	eb 9e                	jmp    80106005 <trap+0x135>
80106067:	89 f6                	mov    %esi,%esi
80106069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80106070:	e8 4b da ff ff       	call   80103ac0 <myproc>
80106075:	8b 58 24             	mov    0x24(%eax),%ebx
80106078:	85 db                	test   %ebx,%ebx
8010607a:	75 2c                	jne    801060a8 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
8010607c:	e8 3f da ff ff       	call   80103ac0 <myproc>
80106081:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80106084:	e8 97 ee ff ff       	call   80104f20 <syscall>
    if(myproc()->killed)
80106089:	e8 32 da ff ff       	call   80103ac0 <myproc>
8010608e:	8b 48 24             	mov    0x24(%eax),%ecx
80106091:	85 c9                	test   %ecx,%ecx
80106093:	0f 84 26 ff ff ff    	je     80105fbf <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80106099:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010609c:	5b                   	pop    %ebx
8010609d:	5e                   	pop    %esi
8010609e:	5f                   	pop    %edi
8010609f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
801060a0:	e9 4b de ff ff       	jmp    80103ef0 <exit>
801060a5:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
801060a8:	e8 43 de ff ff       	call   80103ef0 <exit>
801060ad:	eb cd                	jmp    8010607c <trap+0x1ac>
801060af:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
801060b0:	83 ec 0c             	sub    $0xc,%esp
801060b3:	68 20 61 11 80       	push   $0x80116120
801060b8:	e8 63 e9 ff ff       	call   80104a20 <acquire>
      ticks++;
      wakeup(&ticks);
801060bd:	c7 04 24 60 69 11 80 	movl   $0x80116960,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
801060c4:	83 05 60 69 11 80 01 	addl   $0x1,0x80116960
      wakeup(&ticks);
801060cb:	e8 60 e1 ff ff       	call   80104230 <wakeup>
      release(&tickslock);
801060d0:	c7 04 24 20 61 11 80 	movl   $0x80116120,(%esp)
801060d7:	e8 f4 e9 ff ff       	call   80104ad0 <release>
801060dc:	83 c4 10             	add    $0x10,%esp
801060df:	e9 21 ff ff ff       	jmp    80106005 <trap+0x135>
801060e4:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801060e7:	8b 5f 38             	mov    0x38(%edi),%ebx
801060ea:	e8 b1 d9 ff ff       	call   80103aa0 <cpuid>
801060ef:	83 ec 0c             	sub    $0xc,%esp
801060f2:	56                   	push   %esi
801060f3:	53                   	push   %ebx
801060f4:	50                   	push   %eax
801060f5:	ff 77 30             	pushl  0x30(%edi)
801060f8:	68 a4 7f 10 80       	push   $0x80107fa4
801060fd:	e8 5e a5 ff ff       	call   80100660 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80106102:	83 c4 14             	add    $0x14,%esp
80106105:	68 7b 7f 10 80       	push   $0x80107f7b
8010610a:	e8 61 a2 ff ff       	call   80100370 <panic>
8010610f:	90                   	nop

80106110 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106110:	a1 fc b5 10 80       	mov    0x8010b5fc,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80106115:	55                   	push   %ebp
80106116:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106118:	85 c0                	test   %eax,%eax
8010611a:	74 1c                	je     80106138 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010611c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106121:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106122:	a8 01                	test   $0x1,%al
80106124:	74 12                	je     80106138 <uartgetc+0x28>
80106126:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010612b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010612c:	0f b6 c0             	movzbl %al,%eax
}
8010612f:	5d                   	pop    %ebp
80106130:	c3                   	ret    
80106131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80106138:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
8010613d:	5d                   	pop    %ebp
8010613e:	c3                   	ret    
8010613f:	90                   	nop

80106140 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80106140:	55                   	push   %ebp
80106141:	89 e5                	mov    %esp,%ebp
80106143:	57                   	push   %edi
80106144:	56                   	push   %esi
80106145:	53                   	push   %ebx
80106146:	89 c7                	mov    %eax,%edi
80106148:	bb 80 00 00 00       	mov    $0x80,%ebx
8010614d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106152:	83 ec 0c             	sub    $0xc,%esp
80106155:	eb 1b                	jmp    80106172 <uartputc.part.0+0x32>
80106157:	89 f6                	mov    %esi,%esi
80106159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80106160:	83 ec 0c             	sub    $0xc,%esp
80106163:	6a 0a                	push   $0xa
80106165:	e8 f6 c8 ff ff       	call   80102a60 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010616a:	83 c4 10             	add    $0x10,%esp
8010616d:	83 eb 01             	sub    $0x1,%ebx
80106170:	74 07                	je     80106179 <uartputc.part.0+0x39>
80106172:	89 f2                	mov    %esi,%edx
80106174:	ec                   	in     (%dx),%al
80106175:	a8 20                	test   $0x20,%al
80106177:	74 e7                	je     80106160 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106179:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010617e:	89 f8                	mov    %edi,%eax
80106180:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80106181:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106184:	5b                   	pop    %ebx
80106185:	5e                   	pop    %esi
80106186:	5f                   	pop    %edi
80106187:	5d                   	pop    %ebp
80106188:	c3                   	ret    
80106189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106190 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106190:	55                   	push   %ebp
80106191:	31 c9                	xor    %ecx,%ecx
80106193:	89 c8                	mov    %ecx,%eax
80106195:	89 e5                	mov    %esp,%ebp
80106197:	57                   	push   %edi
80106198:	56                   	push   %esi
80106199:	53                   	push   %ebx
8010619a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010619f:	89 da                	mov    %ebx,%edx
801061a1:	83 ec 0c             	sub    $0xc,%esp
801061a4:	ee                   	out    %al,(%dx)
801061a5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801061aa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801061af:	89 fa                	mov    %edi,%edx
801061b1:	ee                   	out    %al,(%dx)
801061b2:	b8 0c 00 00 00       	mov    $0xc,%eax
801061b7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061bc:	ee                   	out    %al,(%dx)
801061bd:	be f9 03 00 00       	mov    $0x3f9,%esi
801061c2:	89 c8                	mov    %ecx,%eax
801061c4:	89 f2                	mov    %esi,%edx
801061c6:	ee                   	out    %al,(%dx)
801061c7:	b8 03 00 00 00       	mov    $0x3,%eax
801061cc:	89 fa                	mov    %edi,%edx
801061ce:	ee                   	out    %al,(%dx)
801061cf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801061d4:	89 c8                	mov    %ecx,%eax
801061d6:	ee                   	out    %al,(%dx)
801061d7:	b8 01 00 00 00       	mov    $0x1,%eax
801061dc:	89 f2                	mov    %esi,%edx
801061de:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801061df:	ba fd 03 00 00       	mov    $0x3fd,%edx
801061e4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
801061e5:	3c ff                	cmp    $0xff,%al
801061e7:	74 5a                	je     80106243 <uartinit+0xb3>
    return;
  uart = 1;
801061e9:	c7 05 fc b5 10 80 01 	movl   $0x1,0x8010b5fc
801061f0:	00 00 00 
801061f3:	89 da                	mov    %ebx,%edx
801061f5:	ec                   	in     (%dx),%al
801061f6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061fb:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
801061fc:	83 ec 08             	sub    $0x8,%esp
801061ff:	bb 9c 80 10 80       	mov    $0x8010809c,%ebx
80106204:	6a 00                	push   $0x0
80106206:	6a 04                	push   $0x4
80106208:	e8 c3 c3 ff ff       	call   801025d0 <ioapicenable>
8010620d:	83 c4 10             	add    $0x10,%esp
80106210:	b8 78 00 00 00       	mov    $0x78,%eax
80106215:	eb 13                	jmp    8010622a <uartinit+0x9a>
80106217:	89 f6                	mov    %esi,%esi
80106219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106220:	83 c3 01             	add    $0x1,%ebx
80106223:	0f be 03             	movsbl (%ebx),%eax
80106226:	84 c0                	test   %al,%al
80106228:	74 19                	je     80106243 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
8010622a:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
80106230:	85 d2                	test   %edx,%edx
80106232:	74 ec                	je     80106220 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106234:	83 c3 01             	add    $0x1,%ebx
80106237:	e8 04 ff ff ff       	call   80106140 <uartputc.part.0>
8010623c:	0f be 03             	movsbl (%ebx),%eax
8010623f:	84 c0                	test   %al,%al
80106241:	75 e7                	jne    8010622a <uartinit+0x9a>
    uartputc(*p);
}
80106243:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106246:	5b                   	pop    %ebx
80106247:	5e                   	pop    %esi
80106248:	5f                   	pop    %edi
80106249:	5d                   	pop    %ebp
8010624a:	c3                   	ret    
8010624b:	90                   	nop
8010624c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106250 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80106250:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80106256:	55                   	push   %ebp
80106257:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80106259:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
8010625b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
8010625e:	74 10                	je     80106270 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106260:	5d                   	pop    %ebp
80106261:	e9 da fe ff ff       	jmp    80106140 <uartputc.part.0>
80106266:	8d 76 00             	lea    0x0(%esi),%esi
80106269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106270:	5d                   	pop    %ebp
80106271:	c3                   	ret    
80106272:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106280 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80106280:	55                   	push   %ebp
80106281:	89 e5                	mov    %esp,%ebp
80106283:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106286:	68 10 61 10 80       	push   $0x80106110
8010628b:	e8 40 a8 ff ff       	call   80100ad0 <consoleintr>
}
80106290:	83 c4 10             	add    $0x10,%esp
80106293:	c9                   	leave  
80106294:	c3                   	ret    

80106295 <vector0>:
80106295:	6a 00                	push   $0x0
80106297:	6a 00                	push   $0x0
80106299:	e9 34 fb ff ff       	jmp    80105dd2 <alltraps>

8010629e <vector1>:
8010629e:	6a 00                	push   $0x0
801062a0:	6a 01                	push   $0x1
801062a2:	e9 2b fb ff ff       	jmp    80105dd2 <alltraps>

801062a7 <vector2>:
801062a7:	6a 00                	push   $0x0
801062a9:	6a 02                	push   $0x2
801062ab:	e9 22 fb ff ff       	jmp    80105dd2 <alltraps>

801062b0 <vector3>:
801062b0:	6a 00                	push   $0x0
801062b2:	6a 03                	push   $0x3
801062b4:	e9 19 fb ff ff       	jmp    80105dd2 <alltraps>

801062b9 <vector4>:
801062b9:	6a 00                	push   $0x0
801062bb:	6a 04                	push   $0x4
801062bd:	e9 10 fb ff ff       	jmp    80105dd2 <alltraps>

801062c2 <vector5>:
801062c2:	6a 00                	push   $0x0
801062c4:	6a 05                	push   $0x5
801062c6:	e9 07 fb ff ff       	jmp    80105dd2 <alltraps>

801062cb <vector6>:
801062cb:	6a 00                	push   $0x0
801062cd:	6a 06                	push   $0x6
801062cf:	e9 fe fa ff ff       	jmp    80105dd2 <alltraps>

801062d4 <vector7>:
801062d4:	6a 00                	push   $0x0
801062d6:	6a 07                	push   $0x7
801062d8:	e9 f5 fa ff ff       	jmp    80105dd2 <alltraps>

801062dd <vector8>:
801062dd:	6a 08                	push   $0x8
801062df:	e9 ee fa ff ff       	jmp    80105dd2 <alltraps>

801062e4 <vector9>:
801062e4:	6a 00                	push   $0x0
801062e6:	6a 09                	push   $0x9
801062e8:	e9 e5 fa ff ff       	jmp    80105dd2 <alltraps>

801062ed <vector10>:
801062ed:	6a 0a                	push   $0xa
801062ef:	e9 de fa ff ff       	jmp    80105dd2 <alltraps>

801062f4 <vector11>:
801062f4:	6a 0b                	push   $0xb
801062f6:	e9 d7 fa ff ff       	jmp    80105dd2 <alltraps>

801062fb <vector12>:
801062fb:	6a 0c                	push   $0xc
801062fd:	e9 d0 fa ff ff       	jmp    80105dd2 <alltraps>

80106302 <vector13>:
80106302:	6a 0d                	push   $0xd
80106304:	e9 c9 fa ff ff       	jmp    80105dd2 <alltraps>

80106309 <vector14>:
80106309:	6a 0e                	push   $0xe
8010630b:	e9 c2 fa ff ff       	jmp    80105dd2 <alltraps>

80106310 <vector15>:
80106310:	6a 00                	push   $0x0
80106312:	6a 0f                	push   $0xf
80106314:	e9 b9 fa ff ff       	jmp    80105dd2 <alltraps>

80106319 <vector16>:
80106319:	6a 00                	push   $0x0
8010631b:	6a 10                	push   $0x10
8010631d:	e9 b0 fa ff ff       	jmp    80105dd2 <alltraps>

80106322 <vector17>:
80106322:	6a 11                	push   $0x11
80106324:	e9 a9 fa ff ff       	jmp    80105dd2 <alltraps>

80106329 <vector18>:
80106329:	6a 00                	push   $0x0
8010632b:	6a 12                	push   $0x12
8010632d:	e9 a0 fa ff ff       	jmp    80105dd2 <alltraps>

80106332 <vector19>:
80106332:	6a 00                	push   $0x0
80106334:	6a 13                	push   $0x13
80106336:	e9 97 fa ff ff       	jmp    80105dd2 <alltraps>

8010633b <vector20>:
8010633b:	6a 00                	push   $0x0
8010633d:	6a 14                	push   $0x14
8010633f:	e9 8e fa ff ff       	jmp    80105dd2 <alltraps>

80106344 <vector21>:
80106344:	6a 00                	push   $0x0
80106346:	6a 15                	push   $0x15
80106348:	e9 85 fa ff ff       	jmp    80105dd2 <alltraps>

8010634d <vector22>:
8010634d:	6a 00                	push   $0x0
8010634f:	6a 16                	push   $0x16
80106351:	e9 7c fa ff ff       	jmp    80105dd2 <alltraps>

80106356 <vector23>:
80106356:	6a 00                	push   $0x0
80106358:	6a 17                	push   $0x17
8010635a:	e9 73 fa ff ff       	jmp    80105dd2 <alltraps>

8010635f <vector24>:
8010635f:	6a 00                	push   $0x0
80106361:	6a 18                	push   $0x18
80106363:	e9 6a fa ff ff       	jmp    80105dd2 <alltraps>

80106368 <vector25>:
80106368:	6a 00                	push   $0x0
8010636a:	6a 19                	push   $0x19
8010636c:	e9 61 fa ff ff       	jmp    80105dd2 <alltraps>

80106371 <vector26>:
80106371:	6a 00                	push   $0x0
80106373:	6a 1a                	push   $0x1a
80106375:	e9 58 fa ff ff       	jmp    80105dd2 <alltraps>

8010637a <vector27>:
8010637a:	6a 00                	push   $0x0
8010637c:	6a 1b                	push   $0x1b
8010637e:	e9 4f fa ff ff       	jmp    80105dd2 <alltraps>

80106383 <vector28>:
80106383:	6a 00                	push   $0x0
80106385:	6a 1c                	push   $0x1c
80106387:	e9 46 fa ff ff       	jmp    80105dd2 <alltraps>

8010638c <vector29>:
8010638c:	6a 00                	push   $0x0
8010638e:	6a 1d                	push   $0x1d
80106390:	e9 3d fa ff ff       	jmp    80105dd2 <alltraps>

80106395 <vector30>:
80106395:	6a 00                	push   $0x0
80106397:	6a 1e                	push   $0x1e
80106399:	e9 34 fa ff ff       	jmp    80105dd2 <alltraps>

8010639e <vector31>:
8010639e:	6a 00                	push   $0x0
801063a0:	6a 1f                	push   $0x1f
801063a2:	e9 2b fa ff ff       	jmp    80105dd2 <alltraps>

801063a7 <vector32>:
801063a7:	6a 00                	push   $0x0
801063a9:	6a 20                	push   $0x20
801063ab:	e9 22 fa ff ff       	jmp    80105dd2 <alltraps>

801063b0 <vector33>:
801063b0:	6a 00                	push   $0x0
801063b2:	6a 21                	push   $0x21
801063b4:	e9 19 fa ff ff       	jmp    80105dd2 <alltraps>

801063b9 <vector34>:
801063b9:	6a 00                	push   $0x0
801063bb:	6a 22                	push   $0x22
801063bd:	e9 10 fa ff ff       	jmp    80105dd2 <alltraps>

801063c2 <vector35>:
801063c2:	6a 00                	push   $0x0
801063c4:	6a 23                	push   $0x23
801063c6:	e9 07 fa ff ff       	jmp    80105dd2 <alltraps>

801063cb <vector36>:
801063cb:	6a 00                	push   $0x0
801063cd:	6a 24                	push   $0x24
801063cf:	e9 fe f9 ff ff       	jmp    80105dd2 <alltraps>

801063d4 <vector37>:
801063d4:	6a 00                	push   $0x0
801063d6:	6a 25                	push   $0x25
801063d8:	e9 f5 f9 ff ff       	jmp    80105dd2 <alltraps>

801063dd <vector38>:
801063dd:	6a 00                	push   $0x0
801063df:	6a 26                	push   $0x26
801063e1:	e9 ec f9 ff ff       	jmp    80105dd2 <alltraps>

801063e6 <vector39>:
801063e6:	6a 00                	push   $0x0
801063e8:	6a 27                	push   $0x27
801063ea:	e9 e3 f9 ff ff       	jmp    80105dd2 <alltraps>

801063ef <vector40>:
801063ef:	6a 00                	push   $0x0
801063f1:	6a 28                	push   $0x28
801063f3:	e9 da f9 ff ff       	jmp    80105dd2 <alltraps>

801063f8 <vector41>:
801063f8:	6a 00                	push   $0x0
801063fa:	6a 29                	push   $0x29
801063fc:	e9 d1 f9 ff ff       	jmp    80105dd2 <alltraps>

80106401 <vector42>:
80106401:	6a 00                	push   $0x0
80106403:	6a 2a                	push   $0x2a
80106405:	e9 c8 f9 ff ff       	jmp    80105dd2 <alltraps>

8010640a <vector43>:
8010640a:	6a 00                	push   $0x0
8010640c:	6a 2b                	push   $0x2b
8010640e:	e9 bf f9 ff ff       	jmp    80105dd2 <alltraps>

80106413 <vector44>:
80106413:	6a 00                	push   $0x0
80106415:	6a 2c                	push   $0x2c
80106417:	e9 b6 f9 ff ff       	jmp    80105dd2 <alltraps>

8010641c <vector45>:
8010641c:	6a 00                	push   $0x0
8010641e:	6a 2d                	push   $0x2d
80106420:	e9 ad f9 ff ff       	jmp    80105dd2 <alltraps>

80106425 <vector46>:
80106425:	6a 00                	push   $0x0
80106427:	6a 2e                	push   $0x2e
80106429:	e9 a4 f9 ff ff       	jmp    80105dd2 <alltraps>

8010642e <vector47>:
8010642e:	6a 00                	push   $0x0
80106430:	6a 2f                	push   $0x2f
80106432:	e9 9b f9 ff ff       	jmp    80105dd2 <alltraps>

80106437 <vector48>:
80106437:	6a 00                	push   $0x0
80106439:	6a 30                	push   $0x30
8010643b:	e9 92 f9 ff ff       	jmp    80105dd2 <alltraps>

80106440 <vector49>:
80106440:	6a 00                	push   $0x0
80106442:	6a 31                	push   $0x31
80106444:	e9 89 f9 ff ff       	jmp    80105dd2 <alltraps>

80106449 <vector50>:
80106449:	6a 00                	push   $0x0
8010644b:	6a 32                	push   $0x32
8010644d:	e9 80 f9 ff ff       	jmp    80105dd2 <alltraps>

80106452 <vector51>:
80106452:	6a 00                	push   $0x0
80106454:	6a 33                	push   $0x33
80106456:	e9 77 f9 ff ff       	jmp    80105dd2 <alltraps>

8010645b <vector52>:
8010645b:	6a 00                	push   $0x0
8010645d:	6a 34                	push   $0x34
8010645f:	e9 6e f9 ff ff       	jmp    80105dd2 <alltraps>

80106464 <vector53>:
80106464:	6a 00                	push   $0x0
80106466:	6a 35                	push   $0x35
80106468:	e9 65 f9 ff ff       	jmp    80105dd2 <alltraps>

8010646d <vector54>:
8010646d:	6a 00                	push   $0x0
8010646f:	6a 36                	push   $0x36
80106471:	e9 5c f9 ff ff       	jmp    80105dd2 <alltraps>

80106476 <vector55>:
80106476:	6a 00                	push   $0x0
80106478:	6a 37                	push   $0x37
8010647a:	e9 53 f9 ff ff       	jmp    80105dd2 <alltraps>

8010647f <vector56>:
8010647f:	6a 00                	push   $0x0
80106481:	6a 38                	push   $0x38
80106483:	e9 4a f9 ff ff       	jmp    80105dd2 <alltraps>

80106488 <vector57>:
80106488:	6a 00                	push   $0x0
8010648a:	6a 39                	push   $0x39
8010648c:	e9 41 f9 ff ff       	jmp    80105dd2 <alltraps>

80106491 <vector58>:
80106491:	6a 00                	push   $0x0
80106493:	6a 3a                	push   $0x3a
80106495:	e9 38 f9 ff ff       	jmp    80105dd2 <alltraps>

8010649a <vector59>:
8010649a:	6a 00                	push   $0x0
8010649c:	6a 3b                	push   $0x3b
8010649e:	e9 2f f9 ff ff       	jmp    80105dd2 <alltraps>

801064a3 <vector60>:
801064a3:	6a 00                	push   $0x0
801064a5:	6a 3c                	push   $0x3c
801064a7:	e9 26 f9 ff ff       	jmp    80105dd2 <alltraps>

801064ac <vector61>:
801064ac:	6a 00                	push   $0x0
801064ae:	6a 3d                	push   $0x3d
801064b0:	e9 1d f9 ff ff       	jmp    80105dd2 <alltraps>

801064b5 <vector62>:
801064b5:	6a 00                	push   $0x0
801064b7:	6a 3e                	push   $0x3e
801064b9:	e9 14 f9 ff ff       	jmp    80105dd2 <alltraps>

801064be <vector63>:
801064be:	6a 00                	push   $0x0
801064c0:	6a 3f                	push   $0x3f
801064c2:	e9 0b f9 ff ff       	jmp    80105dd2 <alltraps>

801064c7 <vector64>:
801064c7:	6a 00                	push   $0x0
801064c9:	6a 40                	push   $0x40
801064cb:	e9 02 f9 ff ff       	jmp    80105dd2 <alltraps>

801064d0 <vector65>:
801064d0:	6a 00                	push   $0x0
801064d2:	6a 41                	push   $0x41
801064d4:	e9 f9 f8 ff ff       	jmp    80105dd2 <alltraps>

801064d9 <vector66>:
801064d9:	6a 00                	push   $0x0
801064db:	6a 42                	push   $0x42
801064dd:	e9 f0 f8 ff ff       	jmp    80105dd2 <alltraps>

801064e2 <vector67>:
801064e2:	6a 00                	push   $0x0
801064e4:	6a 43                	push   $0x43
801064e6:	e9 e7 f8 ff ff       	jmp    80105dd2 <alltraps>

801064eb <vector68>:
801064eb:	6a 00                	push   $0x0
801064ed:	6a 44                	push   $0x44
801064ef:	e9 de f8 ff ff       	jmp    80105dd2 <alltraps>

801064f4 <vector69>:
801064f4:	6a 00                	push   $0x0
801064f6:	6a 45                	push   $0x45
801064f8:	e9 d5 f8 ff ff       	jmp    80105dd2 <alltraps>

801064fd <vector70>:
801064fd:	6a 00                	push   $0x0
801064ff:	6a 46                	push   $0x46
80106501:	e9 cc f8 ff ff       	jmp    80105dd2 <alltraps>

80106506 <vector71>:
80106506:	6a 00                	push   $0x0
80106508:	6a 47                	push   $0x47
8010650a:	e9 c3 f8 ff ff       	jmp    80105dd2 <alltraps>

8010650f <vector72>:
8010650f:	6a 00                	push   $0x0
80106511:	6a 48                	push   $0x48
80106513:	e9 ba f8 ff ff       	jmp    80105dd2 <alltraps>

80106518 <vector73>:
80106518:	6a 00                	push   $0x0
8010651a:	6a 49                	push   $0x49
8010651c:	e9 b1 f8 ff ff       	jmp    80105dd2 <alltraps>

80106521 <vector74>:
80106521:	6a 00                	push   $0x0
80106523:	6a 4a                	push   $0x4a
80106525:	e9 a8 f8 ff ff       	jmp    80105dd2 <alltraps>

8010652a <vector75>:
8010652a:	6a 00                	push   $0x0
8010652c:	6a 4b                	push   $0x4b
8010652e:	e9 9f f8 ff ff       	jmp    80105dd2 <alltraps>

80106533 <vector76>:
80106533:	6a 00                	push   $0x0
80106535:	6a 4c                	push   $0x4c
80106537:	e9 96 f8 ff ff       	jmp    80105dd2 <alltraps>

8010653c <vector77>:
8010653c:	6a 00                	push   $0x0
8010653e:	6a 4d                	push   $0x4d
80106540:	e9 8d f8 ff ff       	jmp    80105dd2 <alltraps>

80106545 <vector78>:
80106545:	6a 00                	push   $0x0
80106547:	6a 4e                	push   $0x4e
80106549:	e9 84 f8 ff ff       	jmp    80105dd2 <alltraps>

8010654e <vector79>:
8010654e:	6a 00                	push   $0x0
80106550:	6a 4f                	push   $0x4f
80106552:	e9 7b f8 ff ff       	jmp    80105dd2 <alltraps>

80106557 <vector80>:
80106557:	6a 00                	push   $0x0
80106559:	6a 50                	push   $0x50
8010655b:	e9 72 f8 ff ff       	jmp    80105dd2 <alltraps>

80106560 <vector81>:
80106560:	6a 00                	push   $0x0
80106562:	6a 51                	push   $0x51
80106564:	e9 69 f8 ff ff       	jmp    80105dd2 <alltraps>

80106569 <vector82>:
80106569:	6a 00                	push   $0x0
8010656b:	6a 52                	push   $0x52
8010656d:	e9 60 f8 ff ff       	jmp    80105dd2 <alltraps>

80106572 <vector83>:
80106572:	6a 00                	push   $0x0
80106574:	6a 53                	push   $0x53
80106576:	e9 57 f8 ff ff       	jmp    80105dd2 <alltraps>

8010657b <vector84>:
8010657b:	6a 00                	push   $0x0
8010657d:	6a 54                	push   $0x54
8010657f:	e9 4e f8 ff ff       	jmp    80105dd2 <alltraps>

80106584 <vector85>:
80106584:	6a 00                	push   $0x0
80106586:	6a 55                	push   $0x55
80106588:	e9 45 f8 ff ff       	jmp    80105dd2 <alltraps>

8010658d <vector86>:
8010658d:	6a 00                	push   $0x0
8010658f:	6a 56                	push   $0x56
80106591:	e9 3c f8 ff ff       	jmp    80105dd2 <alltraps>

80106596 <vector87>:
80106596:	6a 00                	push   $0x0
80106598:	6a 57                	push   $0x57
8010659a:	e9 33 f8 ff ff       	jmp    80105dd2 <alltraps>

8010659f <vector88>:
8010659f:	6a 00                	push   $0x0
801065a1:	6a 58                	push   $0x58
801065a3:	e9 2a f8 ff ff       	jmp    80105dd2 <alltraps>

801065a8 <vector89>:
801065a8:	6a 00                	push   $0x0
801065aa:	6a 59                	push   $0x59
801065ac:	e9 21 f8 ff ff       	jmp    80105dd2 <alltraps>

801065b1 <vector90>:
801065b1:	6a 00                	push   $0x0
801065b3:	6a 5a                	push   $0x5a
801065b5:	e9 18 f8 ff ff       	jmp    80105dd2 <alltraps>

801065ba <vector91>:
801065ba:	6a 00                	push   $0x0
801065bc:	6a 5b                	push   $0x5b
801065be:	e9 0f f8 ff ff       	jmp    80105dd2 <alltraps>

801065c3 <vector92>:
801065c3:	6a 00                	push   $0x0
801065c5:	6a 5c                	push   $0x5c
801065c7:	e9 06 f8 ff ff       	jmp    80105dd2 <alltraps>

801065cc <vector93>:
801065cc:	6a 00                	push   $0x0
801065ce:	6a 5d                	push   $0x5d
801065d0:	e9 fd f7 ff ff       	jmp    80105dd2 <alltraps>

801065d5 <vector94>:
801065d5:	6a 00                	push   $0x0
801065d7:	6a 5e                	push   $0x5e
801065d9:	e9 f4 f7 ff ff       	jmp    80105dd2 <alltraps>

801065de <vector95>:
801065de:	6a 00                	push   $0x0
801065e0:	6a 5f                	push   $0x5f
801065e2:	e9 eb f7 ff ff       	jmp    80105dd2 <alltraps>

801065e7 <vector96>:
801065e7:	6a 00                	push   $0x0
801065e9:	6a 60                	push   $0x60
801065eb:	e9 e2 f7 ff ff       	jmp    80105dd2 <alltraps>

801065f0 <vector97>:
801065f0:	6a 00                	push   $0x0
801065f2:	6a 61                	push   $0x61
801065f4:	e9 d9 f7 ff ff       	jmp    80105dd2 <alltraps>

801065f9 <vector98>:
801065f9:	6a 00                	push   $0x0
801065fb:	6a 62                	push   $0x62
801065fd:	e9 d0 f7 ff ff       	jmp    80105dd2 <alltraps>

80106602 <vector99>:
80106602:	6a 00                	push   $0x0
80106604:	6a 63                	push   $0x63
80106606:	e9 c7 f7 ff ff       	jmp    80105dd2 <alltraps>

8010660b <vector100>:
8010660b:	6a 00                	push   $0x0
8010660d:	6a 64                	push   $0x64
8010660f:	e9 be f7 ff ff       	jmp    80105dd2 <alltraps>

80106614 <vector101>:
80106614:	6a 00                	push   $0x0
80106616:	6a 65                	push   $0x65
80106618:	e9 b5 f7 ff ff       	jmp    80105dd2 <alltraps>

8010661d <vector102>:
8010661d:	6a 00                	push   $0x0
8010661f:	6a 66                	push   $0x66
80106621:	e9 ac f7 ff ff       	jmp    80105dd2 <alltraps>

80106626 <vector103>:
80106626:	6a 00                	push   $0x0
80106628:	6a 67                	push   $0x67
8010662a:	e9 a3 f7 ff ff       	jmp    80105dd2 <alltraps>

8010662f <vector104>:
8010662f:	6a 00                	push   $0x0
80106631:	6a 68                	push   $0x68
80106633:	e9 9a f7 ff ff       	jmp    80105dd2 <alltraps>

80106638 <vector105>:
80106638:	6a 00                	push   $0x0
8010663a:	6a 69                	push   $0x69
8010663c:	e9 91 f7 ff ff       	jmp    80105dd2 <alltraps>

80106641 <vector106>:
80106641:	6a 00                	push   $0x0
80106643:	6a 6a                	push   $0x6a
80106645:	e9 88 f7 ff ff       	jmp    80105dd2 <alltraps>

8010664a <vector107>:
8010664a:	6a 00                	push   $0x0
8010664c:	6a 6b                	push   $0x6b
8010664e:	e9 7f f7 ff ff       	jmp    80105dd2 <alltraps>

80106653 <vector108>:
80106653:	6a 00                	push   $0x0
80106655:	6a 6c                	push   $0x6c
80106657:	e9 76 f7 ff ff       	jmp    80105dd2 <alltraps>

8010665c <vector109>:
8010665c:	6a 00                	push   $0x0
8010665e:	6a 6d                	push   $0x6d
80106660:	e9 6d f7 ff ff       	jmp    80105dd2 <alltraps>

80106665 <vector110>:
80106665:	6a 00                	push   $0x0
80106667:	6a 6e                	push   $0x6e
80106669:	e9 64 f7 ff ff       	jmp    80105dd2 <alltraps>

8010666e <vector111>:
8010666e:	6a 00                	push   $0x0
80106670:	6a 6f                	push   $0x6f
80106672:	e9 5b f7 ff ff       	jmp    80105dd2 <alltraps>

80106677 <vector112>:
80106677:	6a 00                	push   $0x0
80106679:	6a 70                	push   $0x70
8010667b:	e9 52 f7 ff ff       	jmp    80105dd2 <alltraps>

80106680 <vector113>:
80106680:	6a 00                	push   $0x0
80106682:	6a 71                	push   $0x71
80106684:	e9 49 f7 ff ff       	jmp    80105dd2 <alltraps>

80106689 <vector114>:
80106689:	6a 00                	push   $0x0
8010668b:	6a 72                	push   $0x72
8010668d:	e9 40 f7 ff ff       	jmp    80105dd2 <alltraps>

80106692 <vector115>:
80106692:	6a 00                	push   $0x0
80106694:	6a 73                	push   $0x73
80106696:	e9 37 f7 ff ff       	jmp    80105dd2 <alltraps>

8010669b <vector116>:
8010669b:	6a 00                	push   $0x0
8010669d:	6a 74                	push   $0x74
8010669f:	e9 2e f7 ff ff       	jmp    80105dd2 <alltraps>

801066a4 <vector117>:
801066a4:	6a 00                	push   $0x0
801066a6:	6a 75                	push   $0x75
801066a8:	e9 25 f7 ff ff       	jmp    80105dd2 <alltraps>

801066ad <vector118>:
801066ad:	6a 00                	push   $0x0
801066af:	6a 76                	push   $0x76
801066b1:	e9 1c f7 ff ff       	jmp    80105dd2 <alltraps>

801066b6 <vector119>:
801066b6:	6a 00                	push   $0x0
801066b8:	6a 77                	push   $0x77
801066ba:	e9 13 f7 ff ff       	jmp    80105dd2 <alltraps>

801066bf <vector120>:
801066bf:	6a 00                	push   $0x0
801066c1:	6a 78                	push   $0x78
801066c3:	e9 0a f7 ff ff       	jmp    80105dd2 <alltraps>

801066c8 <vector121>:
801066c8:	6a 00                	push   $0x0
801066ca:	6a 79                	push   $0x79
801066cc:	e9 01 f7 ff ff       	jmp    80105dd2 <alltraps>

801066d1 <vector122>:
801066d1:	6a 00                	push   $0x0
801066d3:	6a 7a                	push   $0x7a
801066d5:	e9 f8 f6 ff ff       	jmp    80105dd2 <alltraps>

801066da <vector123>:
801066da:	6a 00                	push   $0x0
801066dc:	6a 7b                	push   $0x7b
801066de:	e9 ef f6 ff ff       	jmp    80105dd2 <alltraps>

801066e3 <vector124>:
801066e3:	6a 00                	push   $0x0
801066e5:	6a 7c                	push   $0x7c
801066e7:	e9 e6 f6 ff ff       	jmp    80105dd2 <alltraps>

801066ec <vector125>:
801066ec:	6a 00                	push   $0x0
801066ee:	6a 7d                	push   $0x7d
801066f0:	e9 dd f6 ff ff       	jmp    80105dd2 <alltraps>

801066f5 <vector126>:
801066f5:	6a 00                	push   $0x0
801066f7:	6a 7e                	push   $0x7e
801066f9:	e9 d4 f6 ff ff       	jmp    80105dd2 <alltraps>

801066fe <vector127>:
801066fe:	6a 00                	push   $0x0
80106700:	6a 7f                	push   $0x7f
80106702:	e9 cb f6 ff ff       	jmp    80105dd2 <alltraps>

80106707 <vector128>:
80106707:	6a 00                	push   $0x0
80106709:	68 80 00 00 00       	push   $0x80
8010670e:	e9 bf f6 ff ff       	jmp    80105dd2 <alltraps>

80106713 <vector129>:
80106713:	6a 00                	push   $0x0
80106715:	68 81 00 00 00       	push   $0x81
8010671a:	e9 b3 f6 ff ff       	jmp    80105dd2 <alltraps>

8010671f <vector130>:
8010671f:	6a 00                	push   $0x0
80106721:	68 82 00 00 00       	push   $0x82
80106726:	e9 a7 f6 ff ff       	jmp    80105dd2 <alltraps>

8010672b <vector131>:
8010672b:	6a 00                	push   $0x0
8010672d:	68 83 00 00 00       	push   $0x83
80106732:	e9 9b f6 ff ff       	jmp    80105dd2 <alltraps>

80106737 <vector132>:
80106737:	6a 00                	push   $0x0
80106739:	68 84 00 00 00       	push   $0x84
8010673e:	e9 8f f6 ff ff       	jmp    80105dd2 <alltraps>

80106743 <vector133>:
80106743:	6a 00                	push   $0x0
80106745:	68 85 00 00 00       	push   $0x85
8010674a:	e9 83 f6 ff ff       	jmp    80105dd2 <alltraps>

8010674f <vector134>:
8010674f:	6a 00                	push   $0x0
80106751:	68 86 00 00 00       	push   $0x86
80106756:	e9 77 f6 ff ff       	jmp    80105dd2 <alltraps>

8010675b <vector135>:
8010675b:	6a 00                	push   $0x0
8010675d:	68 87 00 00 00       	push   $0x87
80106762:	e9 6b f6 ff ff       	jmp    80105dd2 <alltraps>

80106767 <vector136>:
80106767:	6a 00                	push   $0x0
80106769:	68 88 00 00 00       	push   $0x88
8010676e:	e9 5f f6 ff ff       	jmp    80105dd2 <alltraps>

80106773 <vector137>:
80106773:	6a 00                	push   $0x0
80106775:	68 89 00 00 00       	push   $0x89
8010677a:	e9 53 f6 ff ff       	jmp    80105dd2 <alltraps>

8010677f <vector138>:
8010677f:	6a 00                	push   $0x0
80106781:	68 8a 00 00 00       	push   $0x8a
80106786:	e9 47 f6 ff ff       	jmp    80105dd2 <alltraps>

8010678b <vector139>:
8010678b:	6a 00                	push   $0x0
8010678d:	68 8b 00 00 00       	push   $0x8b
80106792:	e9 3b f6 ff ff       	jmp    80105dd2 <alltraps>

80106797 <vector140>:
80106797:	6a 00                	push   $0x0
80106799:	68 8c 00 00 00       	push   $0x8c
8010679e:	e9 2f f6 ff ff       	jmp    80105dd2 <alltraps>

801067a3 <vector141>:
801067a3:	6a 00                	push   $0x0
801067a5:	68 8d 00 00 00       	push   $0x8d
801067aa:	e9 23 f6 ff ff       	jmp    80105dd2 <alltraps>

801067af <vector142>:
801067af:	6a 00                	push   $0x0
801067b1:	68 8e 00 00 00       	push   $0x8e
801067b6:	e9 17 f6 ff ff       	jmp    80105dd2 <alltraps>

801067bb <vector143>:
801067bb:	6a 00                	push   $0x0
801067bd:	68 8f 00 00 00       	push   $0x8f
801067c2:	e9 0b f6 ff ff       	jmp    80105dd2 <alltraps>

801067c7 <vector144>:
801067c7:	6a 00                	push   $0x0
801067c9:	68 90 00 00 00       	push   $0x90
801067ce:	e9 ff f5 ff ff       	jmp    80105dd2 <alltraps>

801067d3 <vector145>:
801067d3:	6a 00                	push   $0x0
801067d5:	68 91 00 00 00       	push   $0x91
801067da:	e9 f3 f5 ff ff       	jmp    80105dd2 <alltraps>

801067df <vector146>:
801067df:	6a 00                	push   $0x0
801067e1:	68 92 00 00 00       	push   $0x92
801067e6:	e9 e7 f5 ff ff       	jmp    80105dd2 <alltraps>

801067eb <vector147>:
801067eb:	6a 00                	push   $0x0
801067ed:	68 93 00 00 00       	push   $0x93
801067f2:	e9 db f5 ff ff       	jmp    80105dd2 <alltraps>

801067f7 <vector148>:
801067f7:	6a 00                	push   $0x0
801067f9:	68 94 00 00 00       	push   $0x94
801067fe:	e9 cf f5 ff ff       	jmp    80105dd2 <alltraps>

80106803 <vector149>:
80106803:	6a 00                	push   $0x0
80106805:	68 95 00 00 00       	push   $0x95
8010680a:	e9 c3 f5 ff ff       	jmp    80105dd2 <alltraps>

8010680f <vector150>:
8010680f:	6a 00                	push   $0x0
80106811:	68 96 00 00 00       	push   $0x96
80106816:	e9 b7 f5 ff ff       	jmp    80105dd2 <alltraps>

8010681b <vector151>:
8010681b:	6a 00                	push   $0x0
8010681d:	68 97 00 00 00       	push   $0x97
80106822:	e9 ab f5 ff ff       	jmp    80105dd2 <alltraps>

80106827 <vector152>:
80106827:	6a 00                	push   $0x0
80106829:	68 98 00 00 00       	push   $0x98
8010682e:	e9 9f f5 ff ff       	jmp    80105dd2 <alltraps>

80106833 <vector153>:
80106833:	6a 00                	push   $0x0
80106835:	68 99 00 00 00       	push   $0x99
8010683a:	e9 93 f5 ff ff       	jmp    80105dd2 <alltraps>

8010683f <vector154>:
8010683f:	6a 00                	push   $0x0
80106841:	68 9a 00 00 00       	push   $0x9a
80106846:	e9 87 f5 ff ff       	jmp    80105dd2 <alltraps>

8010684b <vector155>:
8010684b:	6a 00                	push   $0x0
8010684d:	68 9b 00 00 00       	push   $0x9b
80106852:	e9 7b f5 ff ff       	jmp    80105dd2 <alltraps>

80106857 <vector156>:
80106857:	6a 00                	push   $0x0
80106859:	68 9c 00 00 00       	push   $0x9c
8010685e:	e9 6f f5 ff ff       	jmp    80105dd2 <alltraps>

80106863 <vector157>:
80106863:	6a 00                	push   $0x0
80106865:	68 9d 00 00 00       	push   $0x9d
8010686a:	e9 63 f5 ff ff       	jmp    80105dd2 <alltraps>

8010686f <vector158>:
8010686f:	6a 00                	push   $0x0
80106871:	68 9e 00 00 00       	push   $0x9e
80106876:	e9 57 f5 ff ff       	jmp    80105dd2 <alltraps>

8010687b <vector159>:
8010687b:	6a 00                	push   $0x0
8010687d:	68 9f 00 00 00       	push   $0x9f
80106882:	e9 4b f5 ff ff       	jmp    80105dd2 <alltraps>

80106887 <vector160>:
80106887:	6a 00                	push   $0x0
80106889:	68 a0 00 00 00       	push   $0xa0
8010688e:	e9 3f f5 ff ff       	jmp    80105dd2 <alltraps>

80106893 <vector161>:
80106893:	6a 00                	push   $0x0
80106895:	68 a1 00 00 00       	push   $0xa1
8010689a:	e9 33 f5 ff ff       	jmp    80105dd2 <alltraps>

8010689f <vector162>:
8010689f:	6a 00                	push   $0x0
801068a1:	68 a2 00 00 00       	push   $0xa2
801068a6:	e9 27 f5 ff ff       	jmp    80105dd2 <alltraps>

801068ab <vector163>:
801068ab:	6a 00                	push   $0x0
801068ad:	68 a3 00 00 00       	push   $0xa3
801068b2:	e9 1b f5 ff ff       	jmp    80105dd2 <alltraps>

801068b7 <vector164>:
801068b7:	6a 00                	push   $0x0
801068b9:	68 a4 00 00 00       	push   $0xa4
801068be:	e9 0f f5 ff ff       	jmp    80105dd2 <alltraps>

801068c3 <vector165>:
801068c3:	6a 00                	push   $0x0
801068c5:	68 a5 00 00 00       	push   $0xa5
801068ca:	e9 03 f5 ff ff       	jmp    80105dd2 <alltraps>

801068cf <vector166>:
801068cf:	6a 00                	push   $0x0
801068d1:	68 a6 00 00 00       	push   $0xa6
801068d6:	e9 f7 f4 ff ff       	jmp    80105dd2 <alltraps>

801068db <vector167>:
801068db:	6a 00                	push   $0x0
801068dd:	68 a7 00 00 00       	push   $0xa7
801068e2:	e9 eb f4 ff ff       	jmp    80105dd2 <alltraps>

801068e7 <vector168>:
801068e7:	6a 00                	push   $0x0
801068e9:	68 a8 00 00 00       	push   $0xa8
801068ee:	e9 df f4 ff ff       	jmp    80105dd2 <alltraps>

801068f3 <vector169>:
801068f3:	6a 00                	push   $0x0
801068f5:	68 a9 00 00 00       	push   $0xa9
801068fa:	e9 d3 f4 ff ff       	jmp    80105dd2 <alltraps>

801068ff <vector170>:
801068ff:	6a 00                	push   $0x0
80106901:	68 aa 00 00 00       	push   $0xaa
80106906:	e9 c7 f4 ff ff       	jmp    80105dd2 <alltraps>

8010690b <vector171>:
8010690b:	6a 00                	push   $0x0
8010690d:	68 ab 00 00 00       	push   $0xab
80106912:	e9 bb f4 ff ff       	jmp    80105dd2 <alltraps>

80106917 <vector172>:
80106917:	6a 00                	push   $0x0
80106919:	68 ac 00 00 00       	push   $0xac
8010691e:	e9 af f4 ff ff       	jmp    80105dd2 <alltraps>

80106923 <vector173>:
80106923:	6a 00                	push   $0x0
80106925:	68 ad 00 00 00       	push   $0xad
8010692a:	e9 a3 f4 ff ff       	jmp    80105dd2 <alltraps>

8010692f <vector174>:
8010692f:	6a 00                	push   $0x0
80106931:	68 ae 00 00 00       	push   $0xae
80106936:	e9 97 f4 ff ff       	jmp    80105dd2 <alltraps>

8010693b <vector175>:
8010693b:	6a 00                	push   $0x0
8010693d:	68 af 00 00 00       	push   $0xaf
80106942:	e9 8b f4 ff ff       	jmp    80105dd2 <alltraps>

80106947 <vector176>:
80106947:	6a 00                	push   $0x0
80106949:	68 b0 00 00 00       	push   $0xb0
8010694e:	e9 7f f4 ff ff       	jmp    80105dd2 <alltraps>

80106953 <vector177>:
80106953:	6a 00                	push   $0x0
80106955:	68 b1 00 00 00       	push   $0xb1
8010695a:	e9 73 f4 ff ff       	jmp    80105dd2 <alltraps>

8010695f <vector178>:
8010695f:	6a 00                	push   $0x0
80106961:	68 b2 00 00 00       	push   $0xb2
80106966:	e9 67 f4 ff ff       	jmp    80105dd2 <alltraps>

8010696b <vector179>:
8010696b:	6a 00                	push   $0x0
8010696d:	68 b3 00 00 00       	push   $0xb3
80106972:	e9 5b f4 ff ff       	jmp    80105dd2 <alltraps>

80106977 <vector180>:
80106977:	6a 00                	push   $0x0
80106979:	68 b4 00 00 00       	push   $0xb4
8010697e:	e9 4f f4 ff ff       	jmp    80105dd2 <alltraps>

80106983 <vector181>:
80106983:	6a 00                	push   $0x0
80106985:	68 b5 00 00 00       	push   $0xb5
8010698a:	e9 43 f4 ff ff       	jmp    80105dd2 <alltraps>

8010698f <vector182>:
8010698f:	6a 00                	push   $0x0
80106991:	68 b6 00 00 00       	push   $0xb6
80106996:	e9 37 f4 ff ff       	jmp    80105dd2 <alltraps>

8010699b <vector183>:
8010699b:	6a 00                	push   $0x0
8010699d:	68 b7 00 00 00       	push   $0xb7
801069a2:	e9 2b f4 ff ff       	jmp    80105dd2 <alltraps>

801069a7 <vector184>:
801069a7:	6a 00                	push   $0x0
801069a9:	68 b8 00 00 00       	push   $0xb8
801069ae:	e9 1f f4 ff ff       	jmp    80105dd2 <alltraps>

801069b3 <vector185>:
801069b3:	6a 00                	push   $0x0
801069b5:	68 b9 00 00 00       	push   $0xb9
801069ba:	e9 13 f4 ff ff       	jmp    80105dd2 <alltraps>

801069bf <vector186>:
801069bf:	6a 00                	push   $0x0
801069c1:	68 ba 00 00 00       	push   $0xba
801069c6:	e9 07 f4 ff ff       	jmp    80105dd2 <alltraps>

801069cb <vector187>:
801069cb:	6a 00                	push   $0x0
801069cd:	68 bb 00 00 00       	push   $0xbb
801069d2:	e9 fb f3 ff ff       	jmp    80105dd2 <alltraps>

801069d7 <vector188>:
801069d7:	6a 00                	push   $0x0
801069d9:	68 bc 00 00 00       	push   $0xbc
801069de:	e9 ef f3 ff ff       	jmp    80105dd2 <alltraps>

801069e3 <vector189>:
801069e3:	6a 00                	push   $0x0
801069e5:	68 bd 00 00 00       	push   $0xbd
801069ea:	e9 e3 f3 ff ff       	jmp    80105dd2 <alltraps>

801069ef <vector190>:
801069ef:	6a 00                	push   $0x0
801069f1:	68 be 00 00 00       	push   $0xbe
801069f6:	e9 d7 f3 ff ff       	jmp    80105dd2 <alltraps>

801069fb <vector191>:
801069fb:	6a 00                	push   $0x0
801069fd:	68 bf 00 00 00       	push   $0xbf
80106a02:	e9 cb f3 ff ff       	jmp    80105dd2 <alltraps>

80106a07 <vector192>:
80106a07:	6a 00                	push   $0x0
80106a09:	68 c0 00 00 00       	push   $0xc0
80106a0e:	e9 bf f3 ff ff       	jmp    80105dd2 <alltraps>

80106a13 <vector193>:
80106a13:	6a 00                	push   $0x0
80106a15:	68 c1 00 00 00       	push   $0xc1
80106a1a:	e9 b3 f3 ff ff       	jmp    80105dd2 <alltraps>

80106a1f <vector194>:
80106a1f:	6a 00                	push   $0x0
80106a21:	68 c2 00 00 00       	push   $0xc2
80106a26:	e9 a7 f3 ff ff       	jmp    80105dd2 <alltraps>

80106a2b <vector195>:
80106a2b:	6a 00                	push   $0x0
80106a2d:	68 c3 00 00 00       	push   $0xc3
80106a32:	e9 9b f3 ff ff       	jmp    80105dd2 <alltraps>

80106a37 <vector196>:
80106a37:	6a 00                	push   $0x0
80106a39:	68 c4 00 00 00       	push   $0xc4
80106a3e:	e9 8f f3 ff ff       	jmp    80105dd2 <alltraps>

80106a43 <vector197>:
80106a43:	6a 00                	push   $0x0
80106a45:	68 c5 00 00 00       	push   $0xc5
80106a4a:	e9 83 f3 ff ff       	jmp    80105dd2 <alltraps>

80106a4f <vector198>:
80106a4f:	6a 00                	push   $0x0
80106a51:	68 c6 00 00 00       	push   $0xc6
80106a56:	e9 77 f3 ff ff       	jmp    80105dd2 <alltraps>

80106a5b <vector199>:
80106a5b:	6a 00                	push   $0x0
80106a5d:	68 c7 00 00 00       	push   $0xc7
80106a62:	e9 6b f3 ff ff       	jmp    80105dd2 <alltraps>

80106a67 <vector200>:
80106a67:	6a 00                	push   $0x0
80106a69:	68 c8 00 00 00       	push   $0xc8
80106a6e:	e9 5f f3 ff ff       	jmp    80105dd2 <alltraps>

80106a73 <vector201>:
80106a73:	6a 00                	push   $0x0
80106a75:	68 c9 00 00 00       	push   $0xc9
80106a7a:	e9 53 f3 ff ff       	jmp    80105dd2 <alltraps>

80106a7f <vector202>:
80106a7f:	6a 00                	push   $0x0
80106a81:	68 ca 00 00 00       	push   $0xca
80106a86:	e9 47 f3 ff ff       	jmp    80105dd2 <alltraps>

80106a8b <vector203>:
80106a8b:	6a 00                	push   $0x0
80106a8d:	68 cb 00 00 00       	push   $0xcb
80106a92:	e9 3b f3 ff ff       	jmp    80105dd2 <alltraps>

80106a97 <vector204>:
80106a97:	6a 00                	push   $0x0
80106a99:	68 cc 00 00 00       	push   $0xcc
80106a9e:	e9 2f f3 ff ff       	jmp    80105dd2 <alltraps>

80106aa3 <vector205>:
80106aa3:	6a 00                	push   $0x0
80106aa5:	68 cd 00 00 00       	push   $0xcd
80106aaa:	e9 23 f3 ff ff       	jmp    80105dd2 <alltraps>

80106aaf <vector206>:
80106aaf:	6a 00                	push   $0x0
80106ab1:	68 ce 00 00 00       	push   $0xce
80106ab6:	e9 17 f3 ff ff       	jmp    80105dd2 <alltraps>

80106abb <vector207>:
80106abb:	6a 00                	push   $0x0
80106abd:	68 cf 00 00 00       	push   $0xcf
80106ac2:	e9 0b f3 ff ff       	jmp    80105dd2 <alltraps>

80106ac7 <vector208>:
80106ac7:	6a 00                	push   $0x0
80106ac9:	68 d0 00 00 00       	push   $0xd0
80106ace:	e9 ff f2 ff ff       	jmp    80105dd2 <alltraps>

80106ad3 <vector209>:
80106ad3:	6a 00                	push   $0x0
80106ad5:	68 d1 00 00 00       	push   $0xd1
80106ada:	e9 f3 f2 ff ff       	jmp    80105dd2 <alltraps>

80106adf <vector210>:
80106adf:	6a 00                	push   $0x0
80106ae1:	68 d2 00 00 00       	push   $0xd2
80106ae6:	e9 e7 f2 ff ff       	jmp    80105dd2 <alltraps>

80106aeb <vector211>:
80106aeb:	6a 00                	push   $0x0
80106aed:	68 d3 00 00 00       	push   $0xd3
80106af2:	e9 db f2 ff ff       	jmp    80105dd2 <alltraps>

80106af7 <vector212>:
80106af7:	6a 00                	push   $0x0
80106af9:	68 d4 00 00 00       	push   $0xd4
80106afe:	e9 cf f2 ff ff       	jmp    80105dd2 <alltraps>

80106b03 <vector213>:
80106b03:	6a 00                	push   $0x0
80106b05:	68 d5 00 00 00       	push   $0xd5
80106b0a:	e9 c3 f2 ff ff       	jmp    80105dd2 <alltraps>

80106b0f <vector214>:
80106b0f:	6a 00                	push   $0x0
80106b11:	68 d6 00 00 00       	push   $0xd6
80106b16:	e9 b7 f2 ff ff       	jmp    80105dd2 <alltraps>

80106b1b <vector215>:
80106b1b:	6a 00                	push   $0x0
80106b1d:	68 d7 00 00 00       	push   $0xd7
80106b22:	e9 ab f2 ff ff       	jmp    80105dd2 <alltraps>

80106b27 <vector216>:
80106b27:	6a 00                	push   $0x0
80106b29:	68 d8 00 00 00       	push   $0xd8
80106b2e:	e9 9f f2 ff ff       	jmp    80105dd2 <alltraps>

80106b33 <vector217>:
80106b33:	6a 00                	push   $0x0
80106b35:	68 d9 00 00 00       	push   $0xd9
80106b3a:	e9 93 f2 ff ff       	jmp    80105dd2 <alltraps>

80106b3f <vector218>:
80106b3f:	6a 00                	push   $0x0
80106b41:	68 da 00 00 00       	push   $0xda
80106b46:	e9 87 f2 ff ff       	jmp    80105dd2 <alltraps>

80106b4b <vector219>:
80106b4b:	6a 00                	push   $0x0
80106b4d:	68 db 00 00 00       	push   $0xdb
80106b52:	e9 7b f2 ff ff       	jmp    80105dd2 <alltraps>

80106b57 <vector220>:
80106b57:	6a 00                	push   $0x0
80106b59:	68 dc 00 00 00       	push   $0xdc
80106b5e:	e9 6f f2 ff ff       	jmp    80105dd2 <alltraps>

80106b63 <vector221>:
80106b63:	6a 00                	push   $0x0
80106b65:	68 dd 00 00 00       	push   $0xdd
80106b6a:	e9 63 f2 ff ff       	jmp    80105dd2 <alltraps>

80106b6f <vector222>:
80106b6f:	6a 00                	push   $0x0
80106b71:	68 de 00 00 00       	push   $0xde
80106b76:	e9 57 f2 ff ff       	jmp    80105dd2 <alltraps>

80106b7b <vector223>:
80106b7b:	6a 00                	push   $0x0
80106b7d:	68 df 00 00 00       	push   $0xdf
80106b82:	e9 4b f2 ff ff       	jmp    80105dd2 <alltraps>

80106b87 <vector224>:
80106b87:	6a 00                	push   $0x0
80106b89:	68 e0 00 00 00       	push   $0xe0
80106b8e:	e9 3f f2 ff ff       	jmp    80105dd2 <alltraps>

80106b93 <vector225>:
80106b93:	6a 00                	push   $0x0
80106b95:	68 e1 00 00 00       	push   $0xe1
80106b9a:	e9 33 f2 ff ff       	jmp    80105dd2 <alltraps>

80106b9f <vector226>:
80106b9f:	6a 00                	push   $0x0
80106ba1:	68 e2 00 00 00       	push   $0xe2
80106ba6:	e9 27 f2 ff ff       	jmp    80105dd2 <alltraps>

80106bab <vector227>:
80106bab:	6a 00                	push   $0x0
80106bad:	68 e3 00 00 00       	push   $0xe3
80106bb2:	e9 1b f2 ff ff       	jmp    80105dd2 <alltraps>

80106bb7 <vector228>:
80106bb7:	6a 00                	push   $0x0
80106bb9:	68 e4 00 00 00       	push   $0xe4
80106bbe:	e9 0f f2 ff ff       	jmp    80105dd2 <alltraps>

80106bc3 <vector229>:
80106bc3:	6a 00                	push   $0x0
80106bc5:	68 e5 00 00 00       	push   $0xe5
80106bca:	e9 03 f2 ff ff       	jmp    80105dd2 <alltraps>

80106bcf <vector230>:
80106bcf:	6a 00                	push   $0x0
80106bd1:	68 e6 00 00 00       	push   $0xe6
80106bd6:	e9 f7 f1 ff ff       	jmp    80105dd2 <alltraps>

80106bdb <vector231>:
80106bdb:	6a 00                	push   $0x0
80106bdd:	68 e7 00 00 00       	push   $0xe7
80106be2:	e9 eb f1 ff ff       	jmp    80105dd2 <alltraps>

80106be7 <vector232>:
80106be7:	6a 00                	push   $0x0
80106be9:	68 e8 00 00 00       	push   $0xe8
80106bee:	e9 df f1 ff ff       	jmp    80105dd2 <alltraps>

80106bf3 <vector233>:
80106bf3:	6a 00                	push   $0x0
80106bf5:	68 e9 00 00 00       	push   $0xe9
80106bfa:	e9 d3 f1 ff ff       	jmp    80105dd2 <alltraps>

80106bff <vector234>:
80106bff:	6a 00                	push   $0x0
80106c01:	68 ea 00 00 00       	push   $0xea
80106c06:	e9 c7 f1 ff ff       	jmp    80105dd2 <alltraps>

80106c0b <vector235>:
80106c0b:	6a 00                	push   $0x0
80106c0d:	68 eb 00 00 00       	push   $0xeb
80106c12:	e9 bb f1 ff ff       	jmp    80105dd2 <alltraps>

80106c17 <vector236>:
80106c17:	6a 00                	push   $0x0
80106c19:	68 ec 00 00 00       	push   $0xec
80106c1e:	e9 af f1 ff ff       	jmp    80105dd2 <alltraps>

80106c23 <vector237>:
80106c23:	6a 00                	push   $0x0
80106c25:	68 ed 00 00 00       	push   $0xed
80106c2a:	e9 a3 f1 ff ff       	jmp    80105dd2 <alltraps>

80106c2f <vector238>:
80106c2f:	6a 00                	push   $0x0
80106c31:	68 ee 00 00 00       	push   $0xee
80106c36:	e9 97 f1 ff ff       	jmp    80105dd2 <alltraps>

80106c3b <vector239>:
80106c3b:	6a 00                	push   $0x0
80106c3d:	68 ef 00 00 00       	push   $0xef
80106c42:	e9 8b f1 ff ff       	jmp    80105dd2 <alltraps>

80106c47 <vector240>:
80106c47:	6a 00                	push   $0x0
80106c49:	68 f0 00 00 00       	push   $0xf0
80106c4e:	e9 7f f1 ff ff       	jmp    80105dd2 <alltraps>

80106c53 <vector241>:
80106c53:	6a 00                	push   $0x0
80106c55:	68 f1 00 00 00       	push   $0xf1
80106c5a:	e9 73 f1 ff ff       	jmp    80105dd2 <alltraps>

80106c5f <vector242>:
80106c5f:	6a 00                	push   $0x0
80106c61:	68 f2 00 00 00       	push   $0xf2
80106c66:	e9 67 f1 ff ff       	jmp    80105dd2 <alltraps>

80106c6b <vector243>:
80106c6b:	6a 00                	push   $0x0
80106c6d:	68 f3 00 00 00       	push   $0xf3
80106c72:	e9 5b f1 ff ff       	jmp    80105dd2 <alltraps>

80106c77 <vector244>:
80106c77:	6a 00                	push   $0x0
80106c79:	68 f4 00 00 00       	push   $0xf4
80106c7e:	e9 4f f1 ff ff       	jmp    80105dd2 <alltraps>

80106c83 <vector245>:
80106c83:	6a 00                	push   $0x0
80106c85:	68 f5 00 00 00       	push   $0xf5
80106c8a:	e9 43 f1 ff ff       	jmp    80105dd2 <alltraps>

80106c8f <vector246>:
80106c8f:	6a 00                	push   $0x0
80106c91:	68 f6 00 00 00       	push   $0xf6
80106c96:	e9 37 f1 ff ff       	jmp    80105dd2 <alltraps>

80106c9b <vector247>:
80106c9b:	6a 00                	push   $0x0
80106c9d:	68 f7 00 00 00       	push   $0xf7
80106ca2:	e9 2b f1 ff ff       	jmp    80105dd2 <alltraps>

80106ca7 <vector248>:
80106ca7:	6a 00                	push   $0x0
80106ca9:	68 f8 00 00 00       	push   $0xf8
80106cae:	e9 1f f1 ff ff       	jmp    80105dd2 <alltraps>

80106cb3 <vector249>:
80106cb3:	6a 00                	push   $0x0
80106cb5:	68 f9 00 00 00       	push   $0xf9
80106cba:	e9 13 f1 ff ff       	jmp    80105dd2 <alltraps>

80106cbf <vector250>:
80106cbf:	6a 00                	push   $0x0
80106cc1:	68 fa 00 00 00       	push   $0xfa
80106cc6:	e9 07 f1 ff ff       	jmp    80105dd2 <alltraps>

80106ccb <vector251>:
80106ccb:	6a 00                	push   $0x0
80106ccd:	68 fb 00 00 00       	push   $0xfb
80106cd2:	e9 fb f0 ff ff       	jmp    80105dd2 <alltraps>

80106cd7 <vector252>:
80106cd7:	6a 00                	push   $0x0
80106cd9:	68 fc 00 00 00       	push   $0xfc
80106cde:	e9 ef f0 ff ff       	jmp    80105dd2 <alltraps>

80106ce3 <vector253>:
80106ce3:	6a 00                	push   $0x0
80106ce5:	68 fd 00 00 00       	push   $0xfd
80106cea:	e9 e3 f0 ff ff       	jmp    80105dd2 <alltraps>

80106cef <vector254>:
80106cef:	6a 00                	push   $0x0
80106cf1:	68 fe 00 00 00       	push   $0xfe
80106cf6:	e9 d7 f0 ff ff       	jmp    80105dd2 <alltraps>

80106cfb <vector255>:
80106cfb:	6a 00                	push   $0x0
80106cfd:	68 ff 00 00 00       	push   $0xff
80106d02:	e9 cb f0 ff ff       	jmp    80105dd2 <alltraps>
80106d07:	66 90                	xchg   %ax,%ax
80106d09:	66 90                	xchg   %ax,%ax
80106d0b:	66 90                	xchg   %ax,%ax
80106d0d:	66 90                	xchg   %ax,%ax
80106d0f:	90                   	nop

80106d10 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106d10:	55                   	push   %ebp
80106d11:	89 e5                	mov    %esp,%ebp
80106d13:	57                   	push   %edi
80106d14:	56                   	push   %esi
80106d15:	53                   	push   %ebx
80106d16:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106d18:	c1 ea 16             	shr    $0x16,%edx
80106d1b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106d1e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106d21:	8b 07                	mov    (%edi),%eax
80106d23:	a8 01                	test   $0x1,%al
80106d25:	74 29                	je     80106d50 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106d27:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d2c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106d32:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106d35:	c1 eb 0a             	shr    $0xa,%ebx
80106d38:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
80106d3e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106d41:	5b                   	pop    %ebx
80106d42:	5e                   	pop    %esi
80106d43:	5f                   	pop    %edi
80106d44:	5d                   	pop    %ebp
80106d45:	c3                   	ret    
80106d46:	8d 76 00             	lea    0x0(%esi),%esi
80106d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106d50:	85 c9                	test   %ecx,%ecx
80106d52:	74 2c                	je     80106d80 <walkpgdir+0x70>
80106d54:	e8 67 ba ff ff       	call   801027c0 <kalloc>
80106d59:	85 c0                	test   %eax,%eax
80106d5b:	89 c6                	mov    %eax,%esi
80106d5d:	74 21                	je     80106d80 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80106d5f:	83 ec 04             	sub    $0x4,%esp
80106d62:	68 00 10 00 00       	push   $0x1000
80106d67:	6a 00                	push   $0x0
80106d69:	50                   	push   %eax
80106d6a:	e8 b1 dd ff ff       	call   80104b20 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106d6f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106d75:	83 c4 10             	add    $0x10,%esp
80106d78:	83 c8 07             	or     $0x7,%eax
80106d7b:	89 07                	mov    %eax,(%edi)
80106d7d:	eb b3                	jmp    80106d32 <walkpgdir+0x22>
80106d7f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106d80:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106d83:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106d85:	5b                   	pop    %ebx
80106d86:	5e                   	pop    %esi
80106d87:	5f                   	pop    %edi
80106d88:	5d                   	pop    %ebp
80106d89:	c3                   	ret    
80106d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d90 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106d90:	55                   	push   %ebp
80106d91:	89 e5                	mov    %esp,%ebp
80106d93:	57                   	push   %edi
80106d94:	56                   	push   %esi
80106d95:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106d96:	89 d3                	mov    %edx,%ebx
80106d98:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106d9e:	83 ec 1c             	sub    $0x1c,%esp
80106da1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106da4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106da8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106dab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106db0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106db3:	8b 45 0c             	mov    0xc(%ebp),%eax
80106db6:	29 df                	sub    %ebx,%edi
80106db8:	83 c8 01             	or     $0x1,%eax
80106dbb:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106dbe:	eb 15                	jmp    80106dd5 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106dc0:	f6 00 01             	testb  $0x1,(%eax)
80106dc3:	75 45                	jne    80106e0a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106dc5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106dc8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106dcb:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106dcd:	74 31                	je     80106e00 <mappages+0x70>
      break;
    a += PGSIZE;
80106dcf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106dd5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106dd8:	b9 01 00 00 00       	mov    $0x1,%ecx
80106ddd:	89 da                	mov    %ebx,%edx
80106ddf:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106de2:	e8 29 ff ff ff       	call   80106d10 <walkpgdir>
80106de7:	85 c0                	test   %eax,%eax
80106de9:	75 d5                	jne    80106dc0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106deb:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
80106dee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106df3:	5b                   	pop    %ebx
80106df4:	5e                   	pop    %esi
80106df5:	5f                   	pop    %edi
80106df6:	5d                   	pop    %ebp
80106df7:	c3                   	ret    
80106df8:	90                   	nop
80106df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e00:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106e03:	31 c0                	xor    %eax,%eax
}
80106e05:	5b                   	pop    %ebx
80106e06:	5e                   	pop    %esi
80106e07:	5f                   	pop    %edi
80106e08:	5d                   	pop    %ebp
80106e09:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106e0a:	83 ec 0c             	sub    $0xc,%esp
80106e0d:	68 a4 80 10 80       	push   $0x801080a4
80106e12:	e8 59 95 ff ff       	call   80100370 <panic>
80106e17:	89 f6                	mov    %esi,%esi
80106e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e20 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106e20:	55                   	push   %ebp
80106e21:	89 e5                	mov    %esp,%ebp
80106e23:	57                   	push   %edi
80106e24:	56                   	push   %esi
80106e25:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106e26:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106e2c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106e2e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106e34:	83 ec 1c             	sub    $0x1c,%esp
80106e37:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106e3a:	39 d3                	cmp    %edx,%ebx
80106e3c:	73 66                	jae    80106ea4 <deallocuvm.part.0+0x84>
80106e3e:	89 d6                	mov    %edx,%esi
80106e40:	eb 3d                	jmp    80106e7f <deallocuvm.part.0+0x5f>
80106e42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106e48:	8b 10                	mov    (%eax),%edx
80106e4a:	f6 c2 01             	test   $0x1,%dl
80106e4d:	74 26                	je     80106e75 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106e4f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106e55:	74 58                	je     80106eaf <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106e57:	83 ec 0c             	sub    $0xc,%esp
80106e5a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106e60:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106e63:	52                   	push   %edx
80106e64:	e8 a7 b7 ff ff       	call   80102610 <kfree>
      *pte = 0;
80106e69:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e6c:	83 c4 10             	add    $0x10,%esp
80106e6f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106e75:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e7b:	39 f3                	cmp    %esi,%ebx
80106e7d:	73 25                	jae    80106ea4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106e7f:	31 c9                	xor    %ecx,%ecx
80106e81:	89 da                	mov    %ebx,%edx
80106e83:	89 f8                	mov    %edi,%eax
80106e85:	e8 86 fe ff ff       	call   80106d10 <walkpgdir>
    if(!pte)
80106e8a:	85 c0                	test   %eax,%eax
80106e8c:	75 ba                	jne    80106e48 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106e8e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106e94:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106e9a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ea0:	39 f3                	cmp    %esi,%ebx
80106ea2:	72 db                	jb     80106e7f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106ea4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ea7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106eaa:	5b                   	pop    %ebx
80106eab:	5e                   	pop    %esi
80106eac:	5f                   	pop    %edi
80106ead:	5d                   	pop    %ebp
80106eae:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106eaf:	83 ec 0c             	sub    $0xc,%esp
80106eb2:	68 06 79 10 80       	push   $0x80107906
80106eb7:	e8 b4 94 ff ff       	call   80100370 <panic>
80106ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ec0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106ec0:	55                   	push   %ebp
80106ec1:	89 e5                	mov    %esp,%ebp
80106ec3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106ec6:	e8 d5 cb ff ff       	call   80103aa0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106ecb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106ed1:	31 c9                	xor    %ecx,%ecx
80106ed3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106ed8:	66 89 90 b8 3a 11 80 	mov    %dx,-0x7feec548(%eax)
80106edf:	66 89 88 ba 3a 11 80 	mov    %cx,-0x7feec546(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ee6:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106eeb:	31 c9                	xor    %ecx,%ecx
80106eed:	66 89 90 c0 3a 11 80 	mov    %dx,-0x7feec540(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ef4:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ef9:	66 89 88 c2 3a 11 80 	mov    %cx,-0x7feec53e(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106f00:	31 c9                	xor    %ecx,%ecx
80106f02:	66 89 90 c8 3a 11 80 	mov    %dx,-0x7feec538(%eax)
80106f09:	66 89 88 ca 3a 11 80 	mov    %cx,-0x7feec536(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106f10:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106f15:	31 c9                	xor    %ecx,%ecx
80106f17:	66 89 90 d0 3a 11 80 	mov    %dx,-0x7feec530(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106f1e:	c6 80 bc 3a 11 80 00 	movb   $0x0,-0x7feec544(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106f25:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106f2a:	c6 80 bd 3a 11 80 9a 	movb   $0x9a,-0x7feec543(%eax)
80106f31:	c6 80 be 3a 11 80 cf 	movb   $0xcf,-0x7feec542(%eax)
80106f38:	c6 80 bf 3a 11 80 00 	movb   $0x0,-0x7feec541(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106f3f:	c6 80 c4 3a 11 80 00 	movb   $0x0,-0x7feec53c(%eax)
80106f46:	c6 80 c5 3a 11 80 92 	movb   $0x92,-0x7feec53b(%eax)
80106f4d:	c6 80 c6 3a 11 80 cf 	movb   $0xcf,-0x7feec53a(%eax)
80106f54:	c6 80 c7 3a 11 80 00 	movb   $0x0,-0x7feec539(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106f5b:	c6 80 cc 3a 11 80 00 	movb   $0x0,-0x7feec534(%eax)
80106f62:	c6 80 cd 3a 11 80 fa 	movb   $0xfa,-0x7feec533(%eax)
80106f69:	c6 80 ce 3a 11 80 cf 	movb   $0xcf,-0x7feec532(%eax)
80106f70:	c6 80 cf 3a 11 80 00 	movb   $0x0,-0x7feec531(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106f77:	66 89 88 d2 3a 11 80 	mov    %cx,-0x7feec52e(%eax)
80106f7e:	c6 80 d4 3a 11 80 00 	movb   $0x0,-0x7feec52c(%eax)
80106f85:	c6 80 d5 3a 11 80 f2 	movb   $0xf2,-0x7feec52b(%eax)
80106f8c:	c6 80 d6 3a 11 80 cf 	movb   $0xcf,-0x7feec52a(%eax)
80106f93:	c6 80 d7 3a 11 80 00 	movb   $0x0,-0x7feec529(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106f9a:	05 b0 3a 11 80       	add    $0x80113ab0,%eax
80106f9f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106fa3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106fa7:	c1 e8 10             	shr    $0x10,%eax
80106faa:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106fae:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106fb1:	0f 01 10             	lgdtl  (%eax)
}
80106fb4:	c9                   	leave  
80106fb5:	c3                   	ret    
80106fb6:	8d 76 00             	lea    0x0(%esi),%esi
80106fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fc0 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106fc0:	a1 64 69 11 80       	mov    0x80116964,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106fc5:	55                   	push   %ebp
80106fc6:	89 e5                	mov    %esp,%ebp
80106fc8:	05 00 00 00 80       	add    $0x80000000,%eax
80106fcd:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106fd0:	5d                   	pop    %ebp
80106fd1:	c3                   	ret    
80106fd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fe0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
80106fe3:	57                   	push   %edi
80106fe4:	56                   	push   %esi
80106fe5:	53                   	push   %ebx
80106fe6:	83 ec 1c             	sub    $0x1c,%esp
80106fe9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106fec:	85 f6                	test   %esi,%esi
80106fee:	0f 84 cd 00 00 00    	je     801070c1 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106ff4:	8b 46 08             	mov    0x8(%esi),%eax
80106ff7:	85 c0                	test   %eax,%eax
80106ff9:	0f 84 dc 00 00 00    	je     801070db <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106fff:	8b 7e 04             	mov    0x4(%esi),%edi
80107002:	85 ff                	test   %edi,%edi
80107004:	0f 84 c4 00 00 00    	je     801070ce <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
8010700a:	e8 31 d9 ff ff       	call   80104940 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010700f:	e8 0c ca ff ff       	call   80103a20 <mycpu>
80107014:	89 c3                	mov    %eax,%ebx
80107016:	e8 05 ca ff ff       	call   80103a20 <mycpu>
8010701b:	89 c7                	mov    %eax,%edi
8010701d:	e8 fe c9 ff ff       	call   80103a20 <mycpu>
80107022:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107025:	83 c7 08             	add    $0x8,%edi
80107028:	e8 f3 c9 ff ff       	call   80103a20 <mycpu>
8010702d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107030:	83 c0 08             	add    $0x8,%eax
80107033:	ba 67 00 00 00       	mov    $0x67,%edx
80107038:	c1 e8 18             	shr    $0x18,%eax
8010703b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107042:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107049:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80107050:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80107057:	83 c1 08             	add    $0x8,%ecx
8010705a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80107060:	c1 e9 10             	shr    $0x10,%ecx
80107063:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107069:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
8010706e:	e8 ad c9 ff ff       	call   80103a20 <mycpu>
80107073:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010707a:	e8 a1 c9 ff ff       	call   80103a20 <mycpu>
8010707f:	b9 10 00 00 00       	mov    $0x10,%ecx
80107084:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107088:	e8 93 c9 ff ff       	call   80103a20 <mycpu>
8010708d:	8b 56 08             	mov    0x8(%esi),%edx
80107090:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80107096:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107099:	e8 82 c9 ff ff       	call   80103a20 <mycpu>
8010709e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
801070a2:	b8 28 00 00 00       	mov    $0x28,%eax
801070a7:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801070aa:	8b 46 04             	mov    0x4(%esi),%eax
801070ad:	05 00 00 00 80       	add    $0x80000000,%eax
801070b2:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
801070b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070b8:	5b                   	pop    %ebx
801070b9:	5e                   	pop    %esi
801070ba:	5f                   	pop    %edi
801070bb:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
801070bc:	e9 bf d8 ff ff       	jmp    80104980 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
801070c1:	83 ec 0c             	sub    $0xc,%esp
801070c4:	68 aa 80 10 80       	push   $0x801080aa
801070c9:	e8 a2 92 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
801070ce:	83 ec 0c             	sub    $0xc,%esp
801070d1:	68 d5 80 10 80       	push   $0x801080d5
801070d6:	e8 95 92 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
801070db:	83 ec 0c             	sub    $0xc,%esp
801070de:	68 c0 80 10 80       	push   $0x801080c0
801070e3:	e8 88 92 ff ff       	call   80100370 <panic>
801070e8:	90                   	nop
801070e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801070f0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801070f0:	55                   	push   %ebp
801070f1:	89 e5                	mov    %esp,%ebp
801070f3:	57                   	push   %edi
801070f4:	56                   	push   %esi
801070f5:	53                   	push   %ebx
801070f6:	83 ec 1c             	sub    $0x1c,%esp
801070f9:	8b 75 10             	mov    0x10(%ebp),%esi
801070fc:	8b 45 08             	mov    0x8(%ebp),%eax
801070ff:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80107102:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107108:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
8010710b:	77 49                	ja     80107156 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
8010710d:	e8 ae b6 ff ff       	call   801027c0 <kalloc>
  memset(mem, 0, PGSIZE);
80107112:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80107115:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107117:	68 00 10 00 00       	push   $0x1000
8010711c:	6a 00                	push   $0x0
8010711e:	50                   	push   %eax
8010711f:	e8 fc d9 ff ff       	call   80104b20 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107124:	58                   	pop    %eax
80107125:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010712b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107130:	5a                   	pop    %edx
80107131:	6a 06                	push   $0x6
80107133:	50                   	push   %eax
80107134:	31 d2                	xor    %edx,%edx
80107136:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107139:	e8 52 fc ff ff       	call   80106d90 <mappages>
  memmove(mem, init, sz);
8010713e:	89 75 10             	mov    %esi,0x10(%ebp)
80107141:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107144:	83 c4 10             	add    $0x10,%esp
80107147:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010714a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010714d:	5b                   	pop    %ebx
8010714e:	5e                   	pop    %esi
8010714f:	5f                   	pop    %edi
80107150:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80107151:	e9 7a da ff ff       	jmp    80104bd0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80107156:	83 ec 0c             	sub    $0xc,%esp
80107159:	68 e9 80 10 80       	push   $0x801080e9
8010715e:	e8 0d 92 ff ff       	call   80100370 <panic>
80107163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107170 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107170:	55                   	push   %ebp
80107171:	89 e5                	mov    %esp,%ebp
80107173:	57                   	push   %edi
80107174:	56                   	push   %esi
80107175:	53                   	push   %ebx
80107176:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107179:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107180:	0f 85 91 00 00 00    	jne    80107217 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107186:	8b 75 18             	mov    0x18(%ebp),%esi
80107189:	31 db                	xor    %ebx,%ebx
8010718b:	85 f6                	test   %esi,%esi
8010718d:	75 1a                	jne    801071a9 <loaduvm+0x39>
8010718f:	eb 6f                	jmp    80107200 <loaduvm+0x90>
80107191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107198:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010719e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801071a4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801071a7:	76 57                	jbe    80107200 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801071a9:	8b 55 0c             	mov    0xc(%ebp),%edx
801071ac:	8b 45 08             	mov    0x8(%ebp),%eax
801071af:	31 c9                	xor    %ecx,%ecx
801071b1:	01 da                	add    %ebx,%edx
801071b3:	e8 58 fb ff ff       	call   80106d10 <walkpgdir>
801071b8:	85 c0                	test   %eax,%eax
801071ba:	74 4e                	je     8010720a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801071bc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801071be:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
801071c1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801071c6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801071cb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801071d1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801071d4:	01 d9                	add    %ebx,%ecx
801071d6:	05 00 00 00 80       	add    $0x80000000,%eax
801071db:	57                   	push   %edi
801071dc:	51                   	push   %ecx
801071dd:	50                   	push   %eax
801071de:	ff 75 10             	pushl  0x10(%ebp)
801071e1:	e8 9a aa ff ff       	call   80101c80 <readi>
801071e6:	83 c4 10             	add    $0x10,%esp
801071e9:	39 c7                	cmp    %eax,%edi
801071eb:	74 ab                	je     80107198 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
801071ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
801071f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
801071f5:	5b                   	pop    %ebx
801071f6:	5e                   	pop    %esi
801071f7:	5f                   	pop    %edi
801071f8:	5d                   	pop    %ebp
801071f9:	c3                   	ret    
801071fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107200:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107203:	31 c0                	xor    %eax,%eax
}
80107205:	5b                   	pop    %ebx
80107206:	5e                   	pop    %esi
80107207:	5f                   	pop    %edi
80107208:	5d                   	pop    %ebp
80107209:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
8010720a:	83 ec 0c             	sub    $0xc,%esp
8010720d:	68 03 81 10 80       	push   $0x80108103
80107212:	e8 59 91 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80107217:	83 ec 0c             	sub    $0xc,%esp
8010721a:	68 a4 81 10 80       	push   $0x801081a4
8010721f:	e8 4c 91 ff ff       	call   80100370 <panic>
80107224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010722a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107230 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107230:	55                   	push   %ebp
80107231:	89 e5                	mov    %esp,%ebp
80107233:	57                   	push   %edi
80107234:	56                   	push   %esi
80107235:	53                   	push   %ebx
80107236:	83 ec 0c             	sub    $0xc,%esp
80107239:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010723c:	85 ff                	test   %edi,%edi
8010723e:	0f 88 ca 00 00 00    	js     8010730e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80107244:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80107247:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
8010724a:	0f 82 82 00 00 00    	jb     801072d2 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80107250:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107256:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010725c:	39 df                	cmp    %ebx,%edi
8010725e:	77 43                	ja     801072a3 <allocuvm+0x73>
80107260:	e9 bb 00 00 00       	jmp    80107320 <allocuvm+0xf0>
80107265:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80107268:	83 ec 04             	sub    $0x4,%esp
8010726b:	68 00 10 00 00       	push   $0x1000
80107270:	6a 00                	push   $0x0
80107272:	50                   	push   %eax
80107273:	e8 a8 d8 ff ff       	call   80104b20 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107278:	58                   	pop    %eax
80107279:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010727f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107284:	5a                   	pop    %edx
80107285:	6a 06                	push   $0x6
80107287:	50                   	push   %eax
80107288:	89 da                	mov    %ebx,%edx
8010728a:	8b 45 08             	mov    0x8(%ebp),%eax
8010728d:	e8 fe fa ff ff       	call   80106d90 <mappages>
80107292:	83 c4 10             	add    $0x10,%esp
80107295:	85 c0                	test   %eax,%eax
80107297:	78 47                	js     801072e0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107299:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010729f:	39 df                	cmp    %ebx,%edi
801072a1:	76 7d                	jbe    80107320 <allocuvm+0xf0>
    mem = kalloc();
801072a3:	e8 18 b5 ff ff       	call   801027c0 <kalloc>
    if(mem == 0){
801072a8:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
801072aa:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801072ac:	75 ba                	jne    80107268 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
801072ae:	83 ec 0c             	sub    $0xc,%esp
801072b1:	68 21 81 10 80       	push   $0x80108121
801072b6:	e8 a5 93 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801072bb:	83 c4 10             	add    $0x10,%esp
801072be:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801072c1:	76 4b                	jbe    8010730e <allocuvm+0xde>
801072c3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801072c6:	8b 45 08             	mov    0x8(%ebp),%eax
801072c9:	89 fa                	mov    %edi,%edx
801072cb:	e8 50 fb ff ff       	call   80106e20 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
801072d0:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
801072d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072d5:	5b                   	pop    %ebx
801072d6:	5e                   	pop    %esi
801072d7:	5f                   	pop    %edi
801072d8:	5d                   	pop    %ebp
801072d9:	c3                   	ret    
801072da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
801072e0:	83 ec 0c             	sub    $0xc,%esp
801072e3:	68 39 81 10 80       	push   $0x80108139
801072e8:	e8 73 93 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801072ed:	83 c4 10             	add    $0x10,%esp
801072f0:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801072f3:	76 0d                	jbe    80107302 <allocuvm+0xd2>
801072f5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801072f8:	8b 45 08             	mov    0x8(%ebp),%eax
801072fb:	89 fa                	mov    %edi,%edx
801072fd:	e8 1e fb ff ff       	call   80106e20 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80107302:	83 ec 0c             	sub    $0xc,%esp
80107305:	56                   	push   %esi
80107306:	e8 05 b3 ff ff       	call   80102610 <kfree>
      return 0;
8010730b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
8010730e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80107311:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80107313:	5b                   	pop    %ebx
80107314:	5e                   	pop    %esi
80107315:	5f                   	pop    %edi
80107316:	5d                   	pop    %ebp
80107317:	c3                   	ret    
80107318:	90                   	nop
80107319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107320:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107323:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80107325:	5b                   	pop    %ebx
80107326:	5e                   	pop    %esi
80107327:	5f                   	pop    %edi
80107328:	5d                   	pop    %ebp
80107329:	c3                   	ret    
8010732a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107330 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107330:	55                   	push   %ebp
80107331:	89 e5                	mov    %esp,%ebp
80107333:	8b 55 0c             	mov    0xc(%ebp),%edx
80107336:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107339:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010733c:	39 d1                	cmp    %edx,%ecx
8010733e:	73 10                	jae    80107350 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107340:	5d                   	pop    %ebp
80107341:	e9 da fa ff ff       	jmp    80106e20 <deallocuvm.part.0>
80107346:	8d 76 00             	lea    0x0(%esi),%esi
80107349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107350:	89 d0                	mov    %edx,%eax
80107352:	5d                   	pop    %ebp
80107353:	c3                   	ret    
80107354:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010735a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107360 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107360:	55                   	push   %ebp
80107361:	89 e5                	mov    %esp,%ebp
80107363:	57                   	push   %edi
80107364:	56                   	push   %esi
80107365:	53                   	push   %ebx
80107366:	83 ec 0c             	sub    $0xc,%esp
80107369:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010736c:	85 f6                	test   %esi,%esi
8010736e:	74 59                	je     801073c9 <freevm+0x69>
80107370:	31 c9                	xor    %ecx,%ecx
80107372:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107377:	89 f0                	mov    %esi,%eax
80107379:	e8 a2 fa ff ff       	call   80106e20 <deallocuvm.part.0>
8010737e:	89 f3                	mov    %esi,%ebx
80107380:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107386:	eb 0f                	jmp    80107397 <freevm+0x37>
80107388:	90                   	nop
80107389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107390:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107393:	39 fb                	cmp    %edi,%ebx
80107395:	74 23                	je     801073ba <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107397:	8b 03                	mov    (%ebx),%eax
80107399:	a8 01                	test   $0x1,%al
8010739b:	74 f3                	je     80107390 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
8010739d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801073a2:	83 ec 0c             	sub    $0xc,%esp
801073a5:	83 c3 04             	add    $0x4,%ebx
801073a8:	05 00 00 00 80       	add    $0x80000000,%eax
801073ad:	50                   	push   %eax
801073ae:	e8 5d b2 ff ff       	call   80102610 <kfree>
801073b3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801073b6:	39 fb                	cmp    %edi,%ebx
801073b8:	75 dd                	jne    80107397 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801073ba:	89 75 08             	mov    %esi,0x8(%ebp)
}
801073bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073c0:	5b                   	pop    %ebx
801073c1:	5e                   	pop    %esi
801073c2:	5f                   	pop    %edi
801073c3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801073c4:	e9 47 b2 ff ff       	jmp    80102610 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
801073c9:	83 ec 0c             	sub    $0xc,%esp
801073cc:	68 55 81 10 80       	push   $0x80108155
801073d1:	e8 9a 8f ff ff       	call   80100370 <panic>
801073d6:	8d 76 00             	lea    0x0(%esi),%esi
801073d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801073e0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
801073e0:	55                   	push   %ebp
801073e1:	89 e5                	mov    %esp,%ebp
801073e3:	56                   	push   %esi
801073e4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
801073e5:	e8 d6 b3 ff ff       	call   801027c0 <kalloc>
801073ea:	85 c0                	test   %eax,%eax
801073ec:	74 6a                	je     80107458 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
801073ee:	83 ec 04             	sub    $0x4,%esp
801073f1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801073f3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
801073f8:	68 00 10 00 00       	push   $0x1000
801073fd:	6a 00                	push   $0x0
801073ff:	50                   	push   %eax
80107400:	e8 1b d7 ff ff       	call   80104b20 <memset>
80107405:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107408:	8b 43 04             	mov    0x4(%ebx),%eax
8010740b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010740e:	83 ec 08             	sub    $0x8,%esp
80107411:	8b 13                	mov    (%ebx),%edx
80107413:	ff 73 0c             	pushl  0xc(%ebx)
80107416:	50                   	push   %eax
80107417:	29 c1                	sub    %eax,%ecx
80107419:	89 f0                	mov    %esi,%eax
8010741b:	e8 70 f9 ff ff       	call   80106d90 <mappages>
80107420:	83 c4 10             	add    $0x10,%esp
80107423:	85 c0                	test   %eax,%eax
80107425:	78 19                	js     80107440 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107427:	83 c3 10             	add    $0x10,%ebx
8010742a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107430:	75 d6                	jne    80107408 <setupkvm+0x28>
80107432:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80107434:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107437:	5b                   	pop    %ebx
80107438:	5e                   	pop    %esi
80107439:	5d                   	pop    %ebp
8010743a:	c3                   	ret    
8010743b:	90                   	nop
8010743c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80107440:	83 ec 0c             	sub    $0xc,%esp
80107443:	56                   	push   %esi
80107444:	e8 17 ff ff ff       	call   80107360 <freevm>
      return 0;
80107449:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
8010744c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
8010744f:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80107451:	5b                   	pop    %ebx
80107452:	5e                   	pop    %esi
80107453:	5d                   	pop    %ebp
80107454:	c3                   	ret    
80107455:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80107458:	31 c0                	xor    %eax,%eax
8010745a:	eb d8                	jmp    80107434 <setupkvm+0x54>
8010745c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107460 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107460:	55                   	push   %ebp
80107461:	89 e5                	mov    %esp,%ebp
80107463:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107466:	e8 75 ff ff ff       	call   801073e0 <setupkvm>
8010746b:	a3 64 69 11 80       	mov    %eax,0x80116964
80107470:	05 00 00 00 80       	add    $0x80000000,%eax
80107475:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80107478:	c9                   	leave  
80107479:	c3                   	ret    
8010747a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107480 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107480:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107481:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107483:	89 e5                	mov    %esp,%ebp
80107485:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107488:	8b 55 0c             	mov    0xc(%ebp),%edx
8010748b:	8b 45 08             	mov    0x8(%ebp),%eax
8010748e:	e8 7d f8 ff ff       	call   80106d10 <walkpgdir>
  if(pte == 0)
80107493:	85 c0                	test   %eax,%eax
80107495:	74 05                	je     8010749c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107497:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010749a:	c9                   	leave  
8010749b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010749c:	83 ec 0c             	sub    $0xc,%esp
8010749f:	68 66 81 10 80       	push   $0x80108166
801074a4:	e8 c7 8e ff ff       	call   80100370 <panic>
801074a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801074b0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801074b0:	55                   	push   %ebp
801074b1:	89 e5                	mov    %esp,%ebp
801074b3:	57                   	push   %edi
801074b4:	56                   	push   %esi
801074b5:	53                   	push   %ebx
801074b6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801074b9:	e8 22 ff ff ff       	call   801073e0 <setupkvm>
801074be:	85 c0                	test   %eax,%eax
801074c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801074c3:	0f 84 c5 00 00 00    	je     8010758e <copyuvm+0xde>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801074c9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801074cc:	85 c9                	test   %ecx,%ecx
801074ce:	0f 84 9c 00 00 00    	je     80107570 <copyuvm+0xc0>
801074d4:	31 ff                	xor    %edi,%edi
801074d6:	eb 4a                	jmp    80107522 <copyuvm+0x72>
801074d8:	90                   	nop
801074d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801074e0:	83 ec 04             	sub    $0x4,%esp
801074e3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801074e9:	68 00 10 00 00       	push   $0x1000
801074ee:	53                   	push   %ebx
801074ef:	50                   	push   %eax
801074f0:	e8 db d6 ff ff       	call   80104bd0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801074f5:	58                   	pop    %eax
801074f6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801074fc:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107501:	5a                   	pop    %edx
80107502:	ff 75 e4             	pushl  -0x1c(%ebp)
80107505:	50                   	push   %eax
80107506:	89 fa                	mov    %edi,%edx
80107508:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010750b:	e8 80 f8 ff ff       	call   80106d90 <mappages>
80107510:	83 c4 10             	add    $0x10,%esp
80107513:	85 c0                	test   %eax,%eax
80107515:	78 69                	js     80107580 <copyuvm+0xd0>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107517:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010751d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107520:	76 4e                	jbe    80107570 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107522:	8b 45 08             	mov    0x8(%ebp),%eax
80107525:	31 c9                	xor    %ecx,%ecx
80107527:	89 fa                	mov    %edi,%edx
80107529:	e8 e2 f7 ff ff       	call   80106d10 <walkpgdir>
8010752e:	85 c0                	test   %eax,%eax
80107530:	74 6d                	je     8010759f <copyuvm+0xef>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107532:	8b 00                	mov    (%eax),%eax
80107534:	a8 01                	test   $0x1,%al
80107536:	74 5a                	je     80107592 <copyuvm+0xe2>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107538:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010753a:	25 ff 0f 00 00       	and    $0xfff,%eax
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
8010753f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107545:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107548:	e8 73 b2 ff ff       	call   801027c0 <kalloc>
8010754d:	85 c0                	test   %eax,%eax
8010754f:	89 c6                	mov    %eax,%esi
80107551:	75 8d                	jne    801074e0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107553:	83 ec 0c             	sub    $0xc,%esp
80107556:	ff 75 e0             	pushl  -0x20(%ebp)
80107559:	e8 02 fe ff ff       	call   80107360 <freevm>
  return 0;
8010755e:	83 c4 10             	add    $0x10,%esp
80107561:	31 c0                	xor    %eax,%eax
}
80107563:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107566:	5b                   	pop    %ebx
80107567:	5e                   	pop    %esi
80107568:	5f                   	pop    %edi
80107569:	5d                   	pop    %ebp
8010756a:	c3                   	ret    
8010756b:	90                   	nop
8010756c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107570:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80107573:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107576:	5b                   	pop    %ebx
80107577:	5e                   	pop    %esi
80107578:	5f                   	pop    %edi
80107579:	5d                   	pop    %ebp
8010757a:	c3                   	ret    
8010757b:	90                   	nop
8010757c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80107580:	83 ec 0c             	sub    $0xc,%esp
80107583:	56                   	push   %esi
80107584:	e8 87 b0 ff ff       	call   80102610 <kfree>
      goto bad;
80107589:	83 c4 10             	add    $0x10,%esp
8010758c:	eb c5                	jmp    80107553 <copyuvm+0xa3>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010758e:	31 c0                	xor    %eax,%eax
80107590:	eb d1                	jmp    80107563 <copyuvm+0xb3>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80107592:	83 ec 0c             	sub    $0xc,%esp
80107595:	68 8a 81 10 80       	push   $0x8010818a
8010759a:	e8 d1 8d ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010759f:	83 ec 0c             	sub    $0xc,%esp
801075a2:	68 70 81 10 80       	push   $0x80108170
801075a7:	e8 c4 8d ff ff       	call   80100370 <panic>
801075ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801075b0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801075b0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801075b1:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801075b3:	89 e5                	mov    %esp,%ebp
801075b5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801075b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801075bb:	8b 45 08             	mov    0x8(%ebp),%eax
801075be:	e8 4d f7 ff ff       	call   80106d10 <walkpgdir>
  if((*pte & PTE_P) == 0)
801075c3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801075c5:	89 c2                	mov    %eax,%edx
801075c7:	83 e2 05             	and    $0x5,%edx
801075ca:	83 fa 05             	cmp    $0x5,%edx
801075cd:	75 11                	jne    801075e0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801075cf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
801075d4:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801075d5:	05 00 00 00 80       	add    $0x80000000,%eax
}
801075da:	c3                   	ret    
801075db:	90                   	nop
801075dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
801075e0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
801075e2:	c9                   	leave  
801075e3:	c3                   	ret    
801075e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801075f0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801075f0:	55                   	push   %ebp
801075f1:	89 e5                	mov    %esp,%ebp
801075f3:	57                   	push   %edi
801075f4:	56                   	push   %esi
801075f5:	53                   	push   %ebx
801075f6:	83 ec 1c             	sub    $0x1c,%esp
801075f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801075fc:	8b 55 0c             	mov    0xc(%ebp),%edx
801075ff:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107602:	85 db                	test   %ebx,%ebx
80107604:	75 40                	jne    80107646 <copyout+0x56>
80107606:	eb 70                	jmp    80107678 <copyout+0x88>
80107608:	90                   	nop
80107609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107610:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107613:	89 f1                	mov    %esi,%ecx
80107615:	29 d1                	sub    %edx,%ecx
80107617:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010761d:	39 d9                	cmp    %ebx,%ecx
8010761f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107622:	29 f2                	sub    %esi,%edx
80107624:	83 ec 04             	sub    $0x4,%esp
80107627:	01 d0                	add    %edx,%eax
80107629:	51                   	push   %ecx
8010762a:	57                   	push   %edi
8010762b:	50                   	push   %eax
8010762c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010762f:	e8 9c d5 ff ff       	call   80104bd0 <memmove>
    len -= n;
    buf += n;
80107634:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107637:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010763a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107640:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107642:	29 cb                	sub    %ecx,%ebx
80107644:	74 32                	je     80107678 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107646:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107648:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010764b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010764e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107654:	56                   	push   %esi
80107655:	ff 75 08             	pushl  0x8(%ebp)
80107658:	e8 53 ff ff ff       	call   801075b0 <uva2ka>
    if(pa0 == 0)
8010765d:	83 c4 10             	add    $0x10,%esp
80107660:	85 c0                	test   %eax,%eax
80107662:	75 ac                	jne    80107610 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107664:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107667:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010766c:	5b                   	pop    %ebx
8010766d:	5e                   	pop    %esi
8010766e:	5f                   	pop    %edi
8010766f:	5d                   	pop    %ebp
80107670:	c3                   	ret    
80107671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107678:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010767b:	31 c0                	xor    %eax,%eax
}
8010767d:	5b                   	pop    %ebx
8010767e:	5e                   	pop    %esi
8010767f:	5f                   	pop    %edi
80107680:	5d                   	pop    %ebp
80107681:	c3                   	ret    
