module net

$if windows {
	// This is mainly here for tcc on windows
	// which apparently doesnt have this definition
	#include "@VROOT/vlib/net/ipv6_v6only.h"
}

// Select represents a select operation
enum Select {
	read
	write
	except
}

// SocketType are the available sockets
pub enum SocketType {
	udp = C.SOCK_DGRAM
	tcp = C.SOCK_STREAM
	seqpacket = C.SOCK_SEQPACKET
}

// AddrFamily are the available address families
pub enum AddrFamily {
	unix = C.AF_UNIX
	ip = C.AF_INET
	ip6 = C.AF_INET6
	unspec = C.AF_UNSPEC
}

struct C.addrinfo {
mut:
	ai_family    int
	ai_socktype  int
	ai_flags     int
	ai_protocol  int
	ai_addrlen   int
	ai_addr      voidptr
	ai_canonname voidptr
	ai_next      voidptr
}

struct C.sockaddr_in {
	sin_family int 
	sin_port int
}

fn C.socket(domain AddrFamily, typ SocketType, protocol int) int

// fn C.setsockopt(sockfd int, level int, optname int, optval voidptr, optlen C.socklen_t) int
fn C.setsockopt(sockfd int, level int, optname int, optval voidptr, optlen u32) int

fn C.htonl(hostlong u32) int

fn C.htons(netshort u16) int

// fn C.bind(sockfd int, addr &C.sockaddr, addrlen C.socklen_t) int
// use voidptr for arg 2 becasue sockaddr is a generic descriptor for any kind of socket operation,
// it can also take sockaddr_in depending on the type of socket used in arg 1
fn C.bind(sockfd int, addr &Addr, addrlen u32) int

fn C.listen(sockfd int, backlog int) int

// fn C.accept(sockfd int, addr &C.sockaddr, addrlen &C.socklen_t) int
fn C.accept(sockfd int, addr &Addr, addrlen &u32) int

fn C.getaddrinfo(node charptr, service charptr, hints &C.addrinfo, res &&C.addrinfo) int

fn C.freeaddrinfo(info &C.addrinfo) 

// fn C.connect(sockfd int, addr &C.sockaddr, addrlen C.socklen_t) int
fn C.connect(sockfd int, addr &Addr, addrlen u32) int

// fn C.send(sockfd int, buf voidptr, len size_t, flags int) size_t
fn C.send(sockfd int, buf voidptr, len size_t, flags int) int

// fn C.sendto(sockfd int, buf voidptr, len size_t, flags int, dest_add &C.sockaddr, addrlen C.socklen_t) size_t
fn C.sendto(sockfd int, buf voidptr, len size_t, flags int, dest_add &Addr, addrlen u32) int

// fn C.recv(sockfd int, buf voidptr, len size_t, flags int) size_t
fn C.recv(sockfd int, buf voidptr, len size_t, flags int) int

// fn C.recvfrom(sockfd int, buf voidptr, len size_t, flags int, src_addr &C.sockaddr, addrlen &C.socklen_t) size_t
fn C.recvfrom(sockfd int, buf voidptr, len size_t, flags int, src_addr &Addr, addrlen &u32) int

fn C.shutdown(socket int, how int) int

fn C.ntohs(netshort u16) int

// fn C.getpeername(sockfd int, addr &C.sockaddr, addlen &C.socklen_t) int
fn C.getpeername(sockfd int, addr &Addr, addlen &u32) int

fn C.inet_ntop(af AddrFamily, src voidptr, dst charptr, dst_size int) charptr

fn C.WSAAddressToStringA(lpsaAddress &Addr, dwAddressLength u32, lpProtocolInfo voidptr, lpszAddressString charptr, lpdwAddressStringLength &u32) int

// fn C.getsockname(sockfd int, addr &C.sockaddr, addrlen &C.socklen_t) int
fn C.getsockname(sockfd int, addr &Addr, addrlen &u32) int

fn C.getsockopt(sockfd int, level int, optname int, optval voidptr, optlen &u32) int

// defined in builtin
// fn C.read() int
// fn C.close() int

fn C.ioctlsocket(s int, cmd int, argp &u32) int

fn C.fcntl(fd int, cmd int, arg ...voidptr) int

fn C.@select(ndfs int, readfds &C.fd_set, writefds &C.fd_set, exceptfds &C.fd_set, timeout &C.timeval) int

fn C.FD_ZERO(fdset &C.fd_set)

fn C.FD_SET(fd int, fdset &C.fd_set)

fn C.FD_ISSET(fd int, fdset &C.fd_set) bool

fn C.inet_pton(family AddrFamily, saddr charptr, addr voidptr) int

[typedef]
pub struct C.fd_set {}
