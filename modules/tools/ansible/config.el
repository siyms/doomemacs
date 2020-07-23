;;; tools/ansible/config.el -*- lexical-binding: t; -*-

(use-package! ansible
  :commands ansible-auto-decrypt-encrypt
  :init
  (put 'ansible-vault-password-file 'safe-local-variable #'stringp)
  :config
  (setq ansible-section-face 'font-lock-variable-name-face
        ansible-task-label-face 'font-lock-doc-face)
  (map! :map ansible-key-map
        :localleader
        :desc "Decrypt buffer"          "d" #'ansible-decrypt-buffer
        :desc "Encrypt buffer"          "e" #'ansible-encrypt-buffer
        :desc "Look up in Ansible docs" "h" #'ansible-doc))


(after! ansible-doc
  (set-evil-initial-state! '(ansible-doc-module-mode) 'emacs))


(use-package! jinja2-mode
  :mode "\\.j2$"
  :config
  ;; The default behavior is to reindent the whole buffer on save. This is
  ;; disruptive and imposing. There are indentation commands available; the user
  ;; can decide when they want their code reindented.
  (add-hook! 'jinja2-mode-hook
    (remove-hook 'after-save-hook 'jinja2-indent-buffer t)))


(def-project-mode! +ansible-yaml-mode
  :modes '(yaml-mode)
  :add-hooks '(ansible ansible-auto-decrypt-encrypt ansible-doc-mode)
  :files ("roles/"))
