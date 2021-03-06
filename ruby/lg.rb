#!/usr/bin/env ruby
# encoding: utf-8

require 'openssl'
require "base64"
require "digest/sha2"

password = "1111"
salt = [ 0x1A, 0x16, 0x59, 0x43, 0xAF, 0x02, 0xFA, 0x95, 0x46, 
         0x59, 0xB4, 0x6B, 0x68, 0x0E, 0x80, 0x1C ].pack('c*')

p "password : #{password}, size: #{password.size}"
p "salt     : #{salt}, size: #{salt.size}"

key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(password, salt,
      2000,     # iteratoin
      32)       # key_len(bytes)

p "key size : #{key.size}"
p "key      : #{key}"

d = OpenSSL::Cipher.new("AES-128-CBC")
d.decrypt
d.padding = 0
d.iv      = key[16..-1]
d.key     = key[0..15]

ciphered = [ 0x18, 0x83, 0x36, 0xB1, 0xF4, 0x32, 0x1F, 0x92, 
             0xDC, 0xB3, 0xCF, 0x82, 0xC2, 0x4D, 0xBF, 0x4C, 
             0x9B, 0x48, 0x9C, 0xFE, 0xFA, 0x5D, 0x2A, 0x71, 
             0x16, 0x06, 0x1A, 0x81, 0x3F, 0x4C, 0x21, 0x6E ].pack("c*")

master_key = d.update(ciphered) << d.final
p "master (key, size) : (#{master_key}, #{master_key.size})"

e = OpenSSL::Cipher.new("AES-256-ECB")
e.encrypt

sha256 = OpenSSL::Digest::SHA256.new
e.key  = sha256.digest(master_key)

sector_no = ([0]*32).pack("c*")
encrypted_sector_no = e.update(sector_no) << e.final

p "IV       : #{encrypted_sector_no}"

f = OpenSSL::Cipher.new("AES-256-CBC")
f.decrypt
f.padding = 0
f.iv  = encrypted_sector_no
f.key = master_key

data = [ 0x34, 0xA9, 0xBA, 0xB0, 0x9E, 0x78, 0x25, 0x3D, 0x44, 0x7B, 0x59, 0x00, 0xDC, 0x5B, 0x9E, 0x7B, 0x6D, 0xF5, 0xEB, 0x34, 0x8F, 0x8E, 0x3C, 0xB1, 0xE8, 0x3C, 0xB3, 0x9A, 0x13, 0x3F, 0x35, 0x4D, 0x3B, 0x2E, 0x88, 0x7A, 0xAE, 0x92, 0x83, 0xD0, 0xB5, 0x14, 0x3D, 0xE7, 0xD4, 0x33, 0x34, 0xF0, 0x32, 0x3A, 0xA8, 0x2B, 0x84, 0x79, 0x76, 0x2A, 0x66, 0x49, 0xC4, 0x31, 0xFB, 0x39, 0x13, 0x49, 0x8C, 0x1F, 0xF7, 0x26, 0x0F, 0x85, 0x9B, 0x3B, 0x3D, 0x0E, 0x96, 0x06, 0x37, 0xD5, 0xD1, 0x57, 0x72, 0x06, 0xD4, 0x52, 0x20, 0x4E, 0x5A, 0xE6, 0x20, 0x0D, 0xB0, 0xC9, 0xF5, 0x2B, 0x2A, 0x81, 0xBE, 0xF7, 0x25, 0x91, 0xFE, 0x01, 0xB2, 0xCD, 0xDC, 0x70, 0xFA, 0x92, 0x21, 0x69, 0xBA, 0xAE, 0xCA, 0xC6, 0xB8, 0x16, 0x43, 0x5E, 0xB4, 0xC3, 0x2B, 0xEA, 0xBA, 0x60, 0xAE, 0xF8, 0xC4, 0x2D, 0xC4, 0x7B, 0xCA, 0x82, 0xDA, 0xB4, 0x61, 0x3B, 0xF6, 0x7E, 0xFB, 0xD4, 0xA1, 0x93, 0x97, 0xEB, 0xF5, 0xEF, 0xD1, 0x6E, 0x3D, 0x44, 0xE2, 0xCC, 0x20, 0xD9, 0xBD, 0x79, 0x99, 0xD5, 0x78, 0x42, 0x0E, 0xE8, 0x10, 0x84, 0x7F, 0x9C, 0xC8, 0xF1, 0xB5, 0x42, 0xA5, 0x31, 0xAD, 0xEC, 0x0C, 0x68, 0x55, 0x47, 0xD6, 0x43, 0x94, 0xA0, 0xF6, 0x34, 0xBF, 0x2C, 0xE8, 0xEA, 0x20, 0xF7, 0x9B, 0xC9, 0xCB, 0xAB, 0xB8, 0x74, 0xB7, 0x21, 0xB1, 0xBB, 0xC0, 0xB0, 0x0E, 0xE8, 0xEA, 0xC2, 0xDC, 0x8B, 0x27, 0xE0, 0x44, 0x7F, 0x4A, 0x43, 0xB9, 0x36, 0xAB, 0xF5, 0xB3, 0xAC, 0x28, 0x09, 0x40, 0x25, 0x59, 0x03, 0xC2, 0xBC, 0x9A, 0xFD, 0x9D, 0xDA, 0x72, 0xE6, 0x0D, 0xCF, 0x82, 0x63, 0xA0, 0x5D, 0xAC, 0xAE, 0x14, 0xD0, 0xFD, 0xCA, 0x09, 0x2A, 0x62, 0x58, 0x8C, 0x88, 0x0A, 0xCC, 0x6B, 0xEF, 0x08, 0xB5, 0x30, 0xE4, 0xF4, 0x85, 0x9D, 0x20, 0xC5, 0x2D, 0x58, 0xA6, 0x0E, 0x28, 0xAE, 0x0C, 0x91, 0x4C, 0x2D, 0xBD, 0x82, 0x30, 0xDA, 0xD4, 0xD4, 0xFD, 0x41, 0x23, 0xD2, 0xFF, 0xF4, 0xCD, 0xED, 0x89, 0x85, 0xDD, 0x43, 0x45, 0xB4, 0xDE, 0x8C, 0x8C, 0x70, 0xAA, 0xD7, 0x8D, 0x0D, 0x06, 0x4F, 0x46, 0x47, 0x31, 0x77, 0xA5, 0x33, 0x91, 0x6B, 0x90, 0xD9, 0xA8, 0xAD, 0x87, 0x17, 0x10, 0x51, 0x7A, 0x40, 0x78, 0x1E, 0x8D, 0xE9, 0xDA, 0x2E, 0x46, 0xB7, 0x22, 0x3C, 0x54, 0xA0, 0xE0, 0xC7, 0xA4, 0x68, 0xA7, 0x69, 0xC4, 0x31, 0xA7, 0x45, 0xA7, 0xDB, 0xF0, 0xB8, 0xF6, 0x70, 0x1F, 0xF7, 0xC4, 0x4A, 0x05, 0xFB, 0x55, 0x87, 0xFD, 0xDC, 0xC7, 0x4B, 0x7C, 0xD5, 0xD2, 0x32, 0xEA, 0x15, 0x3E, 0x78, 0xA5, 0x94, 0x3F, 0x56, 0xFA, 0xF6, 0x68, 0x27, 0x22, 0xBC, 0x95, 0xC8, 0x38, 0x84, 0xFD, 0xD7, 0x4E, 0x67, 0x68, 0xA9, 0x60, 0x76, 0x87, 0xBD, 0xF5, 0x70, 0x03, 0xA3, 0xD1, 0x2B, 0xB4, 0x1C, 0x9A, 0xEB, 0x13, 0xD2, 0x3B, 0x63, 0x0A, 0x5F, 0x8C, 0xF0, 0x20, 0x19, 0x9D, 0xEF, 0x41, 0x4D, 0xF9, 0x2D, 0x97, 0x18, 0xA8, 0x15, 0x9F, 0xB0, 0xC7, 0xAD, 0x3C, 0x80, 0x7B, 0x64, 0x7D, 0xC1, 0xF6, 0x33, 0xC2, 0x2C, 0x9D, 0xCC, 0x89, 0xCF, 0x60, 0xF3, 0x94, 0x9E, 0x9B, 0xB2, 0x3C, 0x41, 0x8F, 0xC4, 0x74, 0x48, 0x13, 0x89, 0x28, 0x62, 0x46, 0x1B, 0xCC, 0x11, 0x82, 0x34, 0x92, 0x38, 0x45, 0x6D, 0x02, 0xBA, 0x88, 0xA8, 0x1C, 0xEF, 0x58, 0x1E, 0x4D, 0x00, 0xA6, 0x5C, 0x7F, 0x79, 0xF0, 0x8C, 0xA0, 0xDC, 0x04, 0x4E, 0x89, 0xFB, 0xBB, 0x7A, 0x59, 0xEC, 0xD4, 0xC3, 0x04, 0x98, 0x7F, 0x07, 0x3D, 0xAD, 0xC7, 0x20, 0x6A, 0x45, 0x94, 0xED, 0x4E, 0xCC, 0xFD ].pack("c*")

cleared_text = f.update(data) << f.final
p "decrypted text: #{cleared_text}"
