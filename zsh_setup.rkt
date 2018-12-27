#!/usr/local/bin/racket
#lang racket

(define home (getenv "HOME"))

(define config-map
  `((,(~a home "/.zsh/.zshrc") . ,(~a home "/.zshrc"))
    (,(~a home "/.zsh/.zshenv") . ,(~a home "/.zshenv"))
    (,(~a home "/.zsh/.zsh_private/.ssh/config") . ,(~a home "/.ssh/config"))))

(define (get-backup-name file)
  "Given FILE, return name FILE_backup."
  (~a file "_backup"))

(define (backup-files)
  "Backup files."
  (map (lambda (alist)
         (let ((cfg (cdr alist)))
           (if (file-exists? cfg)
               (let ((backup (get-backup-name cfg)))
                 (when (file-exists? backup)
                   (delete-file backup)
                   (rename-file-or-directory cfg (get-backup-name cfg))))
               (printf "~a doesn't exist yet. OK to symlink.." cfg))))
       config-map))

(define (make-symlinks)
  "Create symlinks using config-map."
  (map (lambda (alist)
         (let ((from (car alist))
               (to (cdr alist)))
           (printf "Making link from ~a to ~a.\n" from to)
           (make-file-or-directory-link from to)))
       config-map))

(define (main)
  "Main entry into script."
  (backup-files)
  (make-symlinks)
  'done)

(main)
