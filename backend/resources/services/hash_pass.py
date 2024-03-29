from werkzeug.security import generate_password_hash, check_password_hash


def pass_hash(password):
    return generate_password_hash(password, method='pbkdf2:sha256')


def hash_check(hash, password):
    return check_password_hash(hash, password)
